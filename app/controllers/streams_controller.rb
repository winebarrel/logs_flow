class StreamsController < ApplicationController
  def index
    @log_group_name = params[:group_id]

    streams = Stream.describe(
      log_group_name: @log_group_name
    )

    streams.sort_by! {|s| -s.creation_time }
    @streams = Kaminari.paginate_array(streams).page(params[:page])

    respond_to do |format|
      format.html
      format.json {render :json => streams}
    end
  end

  def show
    @log_group_name = params[:group_id]
    @log_stream_name = params[:id]

    @events = Event.describe(
      log_group_name: @log_group_name,
      log_stream_name: @log_stream_name,
      next_token: params[:next_token],
      limit: 100
    )

    @events.sort_by! {|e| -e.timestamp }

    respond_to do |format|
      format.html
      format.json {render :json => @events}
    end
  end
end
