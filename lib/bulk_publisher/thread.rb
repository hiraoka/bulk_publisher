class BulkPublisher::Thread
  def initialize( thread_count = 0 )
    @thread_count = thread_count
  end

  def create_thread( run_clazz: nil )
    @threads = []
    @thread_count.times do |i|
      @threads << Thread.new do
        begin
          Thread.pass
          yield
        rescue => e
          puts "ERROR: raise exception. #{e.inspect}"
        end
      end
    end
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
