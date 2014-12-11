class UsaziUtil::Daemon
  def initialize( options )
    @options = options
  end

  def start
    Signal.trap(:INT){
      stop
      exit(0)
    }
    #Process.daemon if @options["daemonize"]
    UsaziUtil::Pid.create

    @thread = UsaziUtil::Thread.new( @options["connection_count"] )

    before_thread

    @thread.create_thread_and_run( run_clazz: clazz ) do
      thread_perform
    end

    after_thread

    stop
  end

  def before_thread
  end

  def thread_perform
  end

  def after_thread
  end

  def stop
    @thread.stop( stop_clazz: clazz )
    UsaziUtil::Pid.delete
    puts "Stopping #{clazz} process."
  end

  def clazz
  end
end
