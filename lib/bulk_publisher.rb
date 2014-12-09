module BulkPublisher
  OPTIOM_KEYS = [
    "host",
    "port",
    "user",
    "pass",
    "ssl",
    "vhost",
    "routing_key"
  ]
  ENVIRONMENT = {
    "host" =>        'PHX_AMQP_HOST',
    "port" =>        'PHX_AMQP_PORT',
    "vhost" =>       'PHX_AMQP_VHOST',
    "user" =>        'PHX_AMQP_USER',
    "pass" =>        'PHX_AMQP_PASS',
    "ssl" =>         'PHX_AMQP_SSL',
    "routing_key" => 'PHX_ROUTING_KEY'
  }
  require "bulk_publisher/daemon"
  require "bulk_publisher/runner"
  require "json"
end
