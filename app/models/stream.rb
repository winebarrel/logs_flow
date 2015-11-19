class Stream < Log
  include ActiveModel::Model

  ATTRIBUTES = %i(
    log_group_name
    log_stream_name
    creation_time
    first_event_timestamp
    last_event_timestamp
    last_ingestion_time
    upload_sequence_token
    arn
    stored_bytes
  )

  attr_accessor *ATTRIBUTES

  class << self
    def describe(options = {})
      paginate = options.delete(:paginate)
      resp = self.cloudwatchlogs.describe_log_streams(options)

      if paginate
        objs = page_to_objs(resp, options)
        objs.instance_variable_set(:@next_token, resp.next_token)
      else
        objs = resp.flat_map do |page|
          page_to_objs(page, options)
        end
      end

      def objs.next_token; @next_token; end

      objs
    end

    private

    def page_to_objs(page, options)
      page.log_streams.map do |stream|
        attrs = stream.to_h
        attrs[:log_group_name] = options[:log_group_name]
        self.new(attrs)
      end
    end
  end # of class methods

  def events(options = {})
    options = {
      log_group_name: self.log_group_name,
      log_stream_name: self.log_stream_name
    }.merge(options)

    Event.describe(options)
  end
end
