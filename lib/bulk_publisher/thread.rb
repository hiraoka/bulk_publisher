class BulkPublisher::Thread
  def initialize( thread_count = 0 )
    @thread_count = thread_count
  end

  def create_thread( run_clazz: nil )
    @threads = []
    @thread_count.times do |i|
      @threads << Thread.new do
        yield
      end
    end
    run_clazz.run if run_clazz
    @threads.each { |t|
      t.join
    }
  rescue => e
    puts "raise unknown exception. #{e}"
    puts e.backtrace
  end

  def stop( stop_clazz: nil )
    stop_clazz.stop if stop_clazz
    @threads.each { |t|
      t.join
    }
  end
end
