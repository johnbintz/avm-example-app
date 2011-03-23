require 'spec_helper'
require 'avm_example'

describe AVMExample do
  before { Capybara.app = self.class.describes }

  let(:title) { 'Upload an XMP file' }

  describe 'GET "index"' do
    it "should return a form" do
      visit '/'
      page.should have_content(title)
      page.should have_xpath('//form[@action="/upload" and @method="post" and @enctype="multipart/form-data"]')

      within('form') do
        page.should have_selector('input[type="file"][name="file"]')
        page.should have_selector('input[type="submit"]')
      end
    end
  end

  describe 'POST "upload"' do
    before { visit '/' }

    context 'no file' do
      it "should fail" do
        click_button("Upload")
        page.should have_content(title)
        page.should have_content("No file provided!")
      end
    end

    context 'bad xmp file' do
      it "should fail" do
        attach_file('file', 'spec/xmp/bad.xmp')
        click_button("Upload")
        page.should have_content(title)
        page.should have_content("Bad XMP file!")
      end
    end

    context 'good xmp file' do
      it "should fail" do
        attach_file('file', 'spec/xmp/good.xmp')
        click_button("Upload")
        page.should have_content(title)
        page.should have_content("Arp's Loop")
        page.should have_content("NASA, ESA, and D.")
      end
    end
  end
end

