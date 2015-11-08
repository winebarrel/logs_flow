class StreamsController < ApplicationController
  def index
    @log_group_name = params[:group_id]

    @streams = Stream.describe(
      log_group_name: @log_group_name
    )
  end

  def show
    @log_group_name = params[:group_id]
    @log_stream_name = params[:id]

    @events = Event.describe(
      log_group_name: @log_group_name,
      log_stream_name: @log_stream_name
    )
  end
end
