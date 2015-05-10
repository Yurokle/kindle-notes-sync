require 'pathname'
require 'logger'
require 'osx_notification'

class KindleSyncApp
  def initialize(drive_path)
    @drive_path = drive_path
    @root_path = Pathname.new File.expand_path('../..', __FILE__)
    @logger = Logger.new(@root_path.join('sync.log'))
  end

  def run
    @logger.log_session do |log|
      log << "Mounted: #{@drive_path}"

      OSXNotification.show(
        title: 'Extremely important as fuck message',
        content: "We've done all the \"work\".\nSo you can drink beer."
      )
    end
  end
end