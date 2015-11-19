module StreamsHelper
  def events_paginate(log_group_name, log_stream_name, events)
    navigator = ''
    href = "/groups/#{u @log_group_name}/streams/#{u @log_stream_name}?next_token="

    if events.next_backward_token
      navigator << content_tag(:span, class: :prev) do
        link_to '‹ Prev', href + u(events.next_backward_token)
      end
    end

    if events.next_forward_token
      navigator << '&nbsp;' if navigator.present?

      navigator << content_tag(:span, class: :next) do
        link_to 'Next ›', href + u(events.next_forward_token)
      end
    end

    if navigator.present?
      content_tag(:nav, navigator, {class: :pagination}, false)
    else
      ''
    end
  end
end
