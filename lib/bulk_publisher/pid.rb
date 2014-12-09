class BulkPublisher::Pid
  class << self
    def create
      pid = Process.pid
      File.write("./pid/pid", "#{pid}")
    end

    def delete
      File.unlink( "./pid/pid" )
    end
  end
end
