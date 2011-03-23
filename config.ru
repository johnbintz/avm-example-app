require 'rubygems'
require 'bundler'

Bundler.require

$: << File.expand_path("lib")

require 'avm_example'

run AVMExample.new

