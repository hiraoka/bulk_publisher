require "subscriber/subscriber"

class Subscriber::Daemon < UsaziUtil::Daemon
  def thread_perform
      subscriber = Subscriber::Subscriber.new( @options )
      subscriber.reserve
  end

  def after_thread
    puts "subscribed message count #{Subscriber::Subscriber.subscribed_count}."

  end

  def clazz
    Subscriber::Subscriber
  end
end
