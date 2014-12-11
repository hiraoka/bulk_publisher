module AmqpParam
  OPTION_KEYS = [
    "host",
    "port",
    "user",
    "pass",
    "ssl",
    "vhost",
    "routing_key"
  ]
  ENVIRONMENT = {
    "host" =>        'BP_AMQP_HOST',
    "port" =>        'BP_AMQP_PORT',
    "vhost" =>       'BP_AMQP_VHOST',
    "user" =>        'BP_AMQP_USER',
    "pass" =>        'BP_AMQP_PASS',
    "ssl" =>         'BP_AMQP_SSL',
    "routing_key" => 'BP_ROUTING_KEY'
  }
end
