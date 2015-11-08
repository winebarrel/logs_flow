class Group < Log
  include ActiveModel::Model

  ATTRIBUTES = %i(
    log_group_name
    creation_time
    retention_in_days
    metric_filter_count
    arn
    stored_bytes
  )

  attr_accessor *ATTRIBUTES

  class << self
    def describe(options = {})
      resp = self.cloudwatchlogs.describe_log_groups(options)

      objs = resp.log_groups.map do |group|
        self.new(group.to_h)
      end

      objs.instance_variable_set(:@next_token, resp.next_token)
      def objs.next_token; @next_token; end

      objs
    end
  end # of class methods

  def streams(options = {})
    options = {
      log_group_name: self.log_group_name
    }.merge(options)

    Stream.describe(options)
  end
end
