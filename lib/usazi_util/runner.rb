module UsaziUtil::Runner
  include AmqpParam

  def start
    puts "Starting #{class_name} process."

    @params = get_params
    @params.merge!( options )

    UsaziUtil::Pid.file = options["pid_file"]

    daemon_name = class_name + "/daemon"
    daemon_class = Module.const_get( daemon_name.classify )

    daemon_class.new(@params).start
  rescue Interrupt #Ctrl+c の処理
    daemon_class.new(@params).stop
  end
end
