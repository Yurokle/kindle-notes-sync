class Logger
  def initialize log_path
    @log_path = log_path
  end

  def log_session &block
    log = []
    begin
      block.call(log)
    rescue Exception => ex
      log << `which ruby`
      log << `ruby -v`
      log << "Error: #{ex.inspect}"
      log << 'Backtrace:'
      log << ex.backtrace.join("\n")
    end

    # We don't initialize a session if nothing printed
    return if log == []

    log.unshift "===== #{Time.new} ====="
    log << "------------------------"

    File.open @log_path, 'a' do |file|
      file.write log.join("\n")
      file.write "\n\n"
    end
  end
end