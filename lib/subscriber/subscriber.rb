require "bunny"

class Subscriber::Subscriber < UsaziUtil::Bunny
  class << self
    attr_accessor :start_time, :subscribed_count, :error_count
  end

  def initialize( options )
    super( options )
    @before_count = 0
    self.class.subscribed_count = 0
    self.class.error_count = 0
  end

  def bunny_perform( queue )
    if self.class.subscribed_count >= @message_count
      self.class.stop
    else
      queue.subscribe do |delivery_info, properties, payload|
        self.class.start_time ||= Time.now
        self.class.subscribed_count += 1
      end
      subscribe_count = self.class.subscribed_count
      if self.class.start_time && @before_count != subscribe_count
        time = Time.now - self.class.start_time
        printf("[#{time}]subscribe count %d\n", subscribe_count )
        @before_count = subscribe_count
      end
    end
  end

end
