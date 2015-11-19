module StreamsHelper
  def events_paginate(log_group_name, log_stream_name, events)
    navigator = ''

    if events.next_backward_token
      navigator << content_tag(:span, class: :prev) do
        link_to '‹ Prev', group_stream_path(log_group_name, log_stream_name, region: @region, next_token: events.next_backward_token)
      end
    end

    if events.next_forward_token
      navigator << '&nbsp;' if navigator.present?

      navigator << content_tag(:span, class: :next) do
        link_to 'Next ›', group_stream_path(log_group_name, log_stream_name, region: @region, next_token: events.next_forward_token)
      end
    end

    if navigator.present?
      content_tag(:nav, navigator, {class: :pagination}, false)
    else
      ''
    end
  end

  def format_event(event)
    raw event.message.chomp.each_line.map {|line|
      timestamp = content_tag(:span, format_timestamp(event.timestamp), {class: :timestamp})
      message = content_tag(:span, line.chomp)
      timestamp + ' ' + message
    }.join("\n")
  end

  def format_timestamp(timestamp)
    timestamp = timestamp.to_s
    usec = timestamp.slice!(-3..-1)
    Time.at(timestamp.to_i, usec.to_i).strftime(Rails.application.config.event_timestamp_format )
  end
end
