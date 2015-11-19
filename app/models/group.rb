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
      paginate = options.delete(:paginate)
      resp = self.cloudwatchlogs.describe_log_groups(options)

      if paginate
        objs = page_to_objs(resp)
        objs.instance_variable_set(:@next_token, resp.next_token)
      else
        objs = resp.flat_map do |page|
          page_to_objs(page)
        end
      end

      def objs.next_token; @next_token; end

      objs
    end

    private

    def page_to_objs(page)
      page.log_groups.map do |group|
        self.new(group.to_h)
      end
    end
  end # of class methods

  def streams(options = {})
    options = {
      log_group_name: self.log_group_name
    }.merge(options)

    Stream.describe(options)
  end
end
