class UsaziUtil::Thread
  def initialize( connection_count = 0 )
    @connection_count = connection_count
  end

  def create_thread_and_run( run_clazz: nil )
    @threads = []
    @connection_count.times do |i|
      @threads << Thread.new do
        Thread.pass
        yield
      end
      percent = ( i + 1 ) * 100 / @connection_count
      printf("\rconnect %d/ %d ( %d percent )", i + 1, @connection_count, percent )
    end
    printf "\n"
    run_clazz.run if run_clazz
    @threads.each { |t|
      t.join
    }
  end

  def stop( stop_clazz: nil )
    stop_clazz.stop if stop_clazz
    @threads.each { |t|
      t.join
    }
  end
end
