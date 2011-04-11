#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require './lib/server'
require 'ruby-debug'

run Server.new

