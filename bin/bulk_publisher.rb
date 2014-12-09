require "bundler"
Bundler.setup

$:.unshift File.expand_path("../../lib", __FILE__)

require "bulk_publisher"
require "bulk_publisher/runner"

BulkPublisher::Runner.start
