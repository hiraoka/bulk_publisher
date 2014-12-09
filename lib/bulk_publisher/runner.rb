require "thor"
require "yaml"
require "bulk_publisher/version"

class BulkPublisher::Runner < Thor
  $0 = "BulkPublisher - #{::BulkPublisher::Version::STRING}"

  desc "start", "Run the bulk_publisher"
  option :daemonize,      type: :boolean, aliases: '-d', desc: "Running as a daemon"
  option :message_count,  required: true, type: :numeric, aliases: '-m', desc: "message count that number of per thread"
  option :thread_count,   default: 5, type: :numeric, aliases: '-t', desc: "thread count"
  option :pid_file,       type: :string, aliases: '-f', desc: "pid file name."
  def start
    puts "Starting bulk_publisher process."

    params = get_params( options )

    BulkPublisher::Pid.file = options["pid_file"]

    BulkPublisher::Daemon.new(params).start
  rescue Interrupt #Ctrl+c の処理
    BulkPublisher::Daemon.new(params).stop
  end

  private

  def get_params( options )
    @params ||= {}
    BulkPublisher::OPTIOM_KEYS.each { |key|
      set_param!( hash: @params, key: key )
    }

    #環境変数から取得する際にtrue/falseが文字列になるので変換
    case @params["ssl"]
    when "true"; @params["ssl"] = true
    when "false"; @params["ssl"] = false
    end

    if options
      @params["thread_count"]  = options["thread_count"]
      @params["message_count"] = options["message_count"]
    end
    @params
  end

  def config_options
    unless @config_options
      config_options ||= ::YAML.load_file('./config/app_settings.yml')
      @config_options = config_options["settings"]
    end
    @config_options
  rescue
    @config_options = {}
  end

  def set_param!( hash:, key: )
    env_key = BulkPublisher::ENVIRONMENT[key]
    hash[key] = ENV[env_key] if env_key
    hash
  end
end


