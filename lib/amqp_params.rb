module AmqpParam
  require "thor"
  require "yaml"
  require "usazi_util/pid"
  require "usazi_util/thread"
  require "clazz_extensions"
  require "usazi_util/daemon"
  require "usazi_util/bunny"

  ClazzExtension.load do
    string :all
  end

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

  def get_params
    params ||= {}
    OPTION_KEYS.each { |key|
      set_param!( hash: params, key: key )
    }

    #環境変数から取得する際にtrue/falseが文字列になるので変換
    case params["ssl"]
    when "true"; params["ssl"] = true
    when "false"; params["ssl"] = false
    end

    params
  end

  def set_param!( hash:, key: )
    env_key = ENVIRONMENT[key]
    hash[key] = ENV[env_key] if env_key
    hash
  end
end
