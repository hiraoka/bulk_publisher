module BulkPublisher
  OPTIOM_KEYS = [
    "host",
    "port",
    "user",
    "pass",
    "ssl",
    "vhost",
    "queue"
  ]
  ENVIRONMENT = {
    "host" =>        'BP_AMQP_HOST',
    "port" =>        'BP_AMQP_PORT',
    "vhost" =>       'BP_AMQP_VHOST',
    "user" =>        'BP_AMQP_USER',
    "pass" =>        'BP_AMQP_PASS',
    "ssl" =>         'BP_AMQP_SSL',
    "queue" =>       'BP_AMQP_QUEUE'
  }
  require "bulk_publisher/daemon"
  require "bulk_publisher/runner"
  require "json"
end
