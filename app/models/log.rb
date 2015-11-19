class Log
  def self.cloudwatchlogs
    Aws::CloudWatchLogs::Client.new
  end
end
