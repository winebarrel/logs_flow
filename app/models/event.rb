class Event < Log
  include ActiveModel::Model

  ATTRIBUTES = %i(
    log_group_name
    log_stream_name
    timestamp
    message
    ingestion_time
  )

  attr_accessor *ATTRIBUTES

  class << self
    def describe(options = {})
      resp = self.cloudwatchlogs.get_log_events(options)

      objs = resp.events.map do |event|
        attrs = event.to_h
        attrs[:log_group_name] = options[:log_group_name]
        attrs[:log_stream_name] = options[:log_stream_name]
        self.new(attrs)
      end

      objs.instance_variable_set(:@next_forward_token, resp.next_forward_token)
      def objs.next_forward_token; @next_forward_token; end

      objs.instance_variable_set(:@next_backward_token, resp.next_backward_token)
      def objs.next_backward_token; @next_backward_token; end

      objs
    end
  end # of class methods
end
