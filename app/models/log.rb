class Log
  class_attribute :cloudwatchlogs
  self.cloudwatchlogs ||= Aws::CloudWatchLogs::Client.new
end
