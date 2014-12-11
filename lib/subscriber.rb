module Subscriber
  require "subscriber/daemon"
  require "subscriber/runner"
  require "amqp_params"
  require "json"
  include ::AmqpParam
end
