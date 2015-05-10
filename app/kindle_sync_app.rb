require 'pathname'
require 'logger'

class KindleSyncApp
  def initialize(drive_path)
    @drive_path = Pathname.new drive_path
    @clippings_path = @drive_path.join('documents/My Clippings.txt')
    @root_path = Pathname.new File.expand_path('../..', __FILE__)
    @logger = Logger.new(@root_path.join('sync.log'))
  end

  def run
    return unless kindle_connected?

    @logger.log_session do |log|
      # we require libraries here make logger catch all low-level exceptions
      require 'rubygems'
      require 'bundler/setup'
      require 'osx_notification'
      require 'my_clippings_parser'

      log << "Mounted: #{@drive_path}"
      log << 'Items:'
      MyClippingsParser.new(@clippings_path).items.reject(&:blank?).each do |item|
        log << "#{item.content} - #{item.book_title}"
      end

      OSXNotification.show(
        title: 'Kindle clippings sync',
        content: "Clippings from your Kindle\nwere successfully synchronized."
      )
    end
  end

  protected

  def kindle_connected?
    File.exists? @clippings_path
  end
end