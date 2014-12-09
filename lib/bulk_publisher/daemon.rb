require "bulk_publisher/pid"
require "bulk_publisher/thread"
require "bulk_publisher/publisher"

class BulkPublisher::Daemon
  def initialize( options )
    @options = options
  end

  def start
    Signal.trap(:INT){
      stop
      exit(0)
    }
    Process.daemon if @options["daemonize"]
    BulkPublisher::Pid.create

    @thread = BulkPublisher::Thread.new( @options["thread_count"] )
    @thread.create_thread( run_clazz: BulkPublisher::Publisher ) do
      publisher = BulkPublisher::Publisher.new( @options )
      publisher.reserve
      puts "running time: #{publisher.running_time}."
    end

    stop
  end

  def stop
    @thread.stop( stop_clazz: BulkPublisher::Publisher )
    BulkPublisher::Pid.delete
    puts "Stopping bulk_publisher process."
  end
end
