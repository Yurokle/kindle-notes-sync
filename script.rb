#!/usr/bin/env ruby

$:.unshift File.expand_path('../app', __FILE__)

require 'kindle_sync_app'

KindleSyncApp.new(ARGV.first).run
