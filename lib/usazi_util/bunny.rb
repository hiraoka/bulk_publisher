class UsaziUtil::Bunny
  class << self
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
    @message_count ||= 0
    @options = options
    @routing_key = options["routing_key"]
  end

  def conn
    options = @options.dup
    options = symbolized_keys(options)
    @conn ||= Bunny.new( options )
  end

  def reserve
    conn.start

    ch = conn.create_channel
    queue  = ch.queue(@routing_key)

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
      bunny_perform( queue )
    end

    conn.stop
    @running_time = Time.now - begin_at
  rescue => e
    self.class.error_count += 1
    puts "ERROR: raise exception. #{e.inspect}"
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
