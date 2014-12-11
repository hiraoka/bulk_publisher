require "bulk_publisher/publisher"

class BulkPublisher::Daemon < UsaziUtil::Daemon
  def thread_perform
    publisher = clazz.new( @options )
    publisher.reserve
    puts "running time: #{publisher.running_time}." unless publisher.running_time.nil?
  end

  def after_thread
    puts "published message count #{clazz.published_count}."
    puts "error count #{clazz.error_count}."
  end

  def clazz
    BulkPublisher::Publisher
  end
end
