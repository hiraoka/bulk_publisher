require "bunny"

class BulkPublisher::Publisher < UsaziUtil::Bunny
  class << self
    attr_accessor :published_count, :error_count
  end

  def initialize( options )
    super(options)
    self.class.published_count = 0
    self.class.error_count = 0
  end

  def bunny_perform( queue )
    queue.publish({"body"=>{"greeting"=>"yo"}, "routing_key"=>@routing_key}.to_json )
    self.class.published_count += 1
  end

  def running_time
    @running_time
  end
end
