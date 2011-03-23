require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/content_for'
require 'avm/image'
require 'coderay'
require 'pp'

class AVMExample < Sinatra::Base
  use Rack::Session::Cookie, :key => 'avm.session',
    :path => '/',
    :expire_after => 60

  configure do
    set :root, File.expand_path('../..',  __FILE__)
  end
  
  register Sinatra::Flash
  helpers Sinatra::ContentFor

  helpers do
    def uploaded?
      @is_uploaded ||= ensure_uploaded_xmp
    end

    def tempfile
      ensure_uploaded_xmp
      @tempfile
    end

    def filename
      ensure_uploaded_xmp
      @filename
    end
  end

  post '/upload' do
    redirect_with_warn("No file provided!") if !uploaded?

    begin
      @image = AVM::Image.from_xml(params[:file][:tempfile].read)
      redirect_with_warn("Bad XMP file!") if !@image.valid?
    rescue StandardError => e
      redirect_with_warn("Error reading XMP file!")
      $stderr.puts e.to_s
    end

    flash[:info] = %{File processed! Data structure is <a href="#data">below</a>.}
    haml :print_data
  end

  get %r{^/?$} do
    haml :index
  end

  private
  def redirect_with_warn(warning)
    flash[:warn] = warning
    redirect '/'
  end

  def ensure_uploaded_xmp
    return false if !params[:file]
    return false if !(@tempfile = params[:file][:tempfile])
    return false if !(@filename = params[:file][:filename])
    true
  end
end
