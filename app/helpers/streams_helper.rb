module StreamsHelper
  def events_paginate(log_group_name, log_stream_name, events)
    navigator = ''

    if events.next_backward_token
      navigator << content_tag(:li, class: :previous) do
        link_to raw('&larr; Older'), group_stream_path(log_group_name, log_stream_name, region: @region, next_token: events.next_backward_token)
      end
    end

    if events.next_forward_token
      navigator << content_tag(:li, class: :next) do
        link_to raw('Newer &rarr;'), group_stream_path(log_group_name, log_stream_name, region: @region, next_token: events.next_forward_token)
      end
    end

    if navigator.present?
      content_tag(:ul, raw(navigator), class: :pager)
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
