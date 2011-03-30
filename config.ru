require 'rubygems'
require 'bundler'

Bundler.require

$: << File.expand_path("lib")

require 'avm_example'
require 'haml'

run AVMExample.new

