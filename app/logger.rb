class Logger
  def initialize log_path
    @log_path = log_path
  end

  def log_session &block
    timestamp = Time.new
    log = []

    File.open @log_path, 'a' do |file|
      log << "===== #{timestamp} ====="

      begin
        block.call(log)
      rescue => ex
        log << ex.inspect
      end

      log << "------------------------"
      file.write log.join("\n")
      file.write "\n\n"
    end
  end
end