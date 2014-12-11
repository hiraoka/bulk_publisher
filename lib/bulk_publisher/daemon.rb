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

    @thread = BulkPublisher::Thread.new( @options["connection_count"] )
    @thread.create_thread_and_run( run_clazz: BulkPublisher::Publisher ) do
      publisher = BulkPublisher::Publisher.new( @options )
      publisher.reserve
      puts "running time: #{publisher.running_time}." unless publisher.running_time.nil?
    end
    puts "published message count #{BulkPublisher::Publisher.published_count}."
    puts "error count #{BulkPublisher::Publisher.error_count}."

    stop
  end

  def stop
    @thread.stop( stop_clazz: BulkPublisher::Publisher )
    BulkPublisher::Pid.delete
    puts "Stopping bulk_publisher process."
  end
end
