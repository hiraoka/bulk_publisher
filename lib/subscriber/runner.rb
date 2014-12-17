require "subscriber/version"
require "usazi_util/runner"

class Subscriber::Runner < Thor
  include UsaziUtil::Runner
  $0 = "Subscriber - #{::Subscriber::Version::STRING}"

  desc "start", "Run the subscriber"
  option :message_count,                  type: :numeric, aliases: '-m', desc: "message count that number of per thread"
  option :connection_count,   default: 1, type: :numeric, aliases: '-c', desc: "connection count"
  option :pid_file,                       type: :string,  aliases: '-P', desc: "pid file name."
  def start
    super()
  end

private
  def class_name
    "subscriber"
  end
end
