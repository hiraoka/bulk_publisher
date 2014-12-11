require "bunny"

class BulkPublisher::Publisher
  class << self
    attr_accessor :published_count, :error_count
    def run
      @ready = true
    end

    def ready?
      @ready
    end

    def stop
      @stop = true
    end

    def stop?
      @stop
    end
  end

  def initialize( options )
    @message_count = options["message_count"]
    @options = options
    @routing_key = options["routing_key"]
    self.class.published_count = 0
    self.class.error_count = 0
  end

  def conn
    options = @options.dup
    options = symbolized_keys(options)
    @conn ||= Bunny.new( options )
  end

  def reserve
    conn.start

    ch = conn.create_channel
    q  = ch.queue(@routing_key)

    #runメソッドが呼ばれるのを待つ
    until ready?
      #stopメソッドが呼ばれたら終了する
      if stop?
        break
      end
      sleep 0.1
    end

    #開始時間を記録
    begin_at = Time.now

    #message_countが0の場合はコネクションだけ貼りっぱなしにする
    while @message_count == 0 do
      #stopメソッドが呼ばれたら終了する
      if stop?
        break
      end
    end

    @message_count.times do |i|
      #stopメソッドが呼ばれたら終了する
      if stop?
        break
      end
      q.publish({"body"=>{"greeting"=>"yo"}, "routing_key"=>@routing_key}.to_json )
      self.class.published_count += 1
    end

    conn.stop
    @running_time = Time.now - begin_at
  rescue => e
    self.class.error_count += 1
    puts "ERROR: raise exception. #{e.inspect}"
  else
  end

  def running_time
    @running_time
  end

private
  def ready?
    self.class.ready?
  end

  def stop?
    self.class.stop?
  end

  def symbolized_keys( hash )
    ret_hash = {}
    hash.keys.each { |key|
      ret_hash[key.to_sym] = hash[key]
    }
    ret_hash
  end
end
