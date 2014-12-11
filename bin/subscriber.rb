require "bundler"
Bundler.setup

$:.unshift File.expand_path("../../lib", __FILE__)

require "subscriber"
require "subscriber/runner"

Subscriber::Runner.start
