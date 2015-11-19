class GroupsController < ApplicationController
  def index
    groups = Group.describe
    groups.sort_by! {|g| -g.creation_time }
    @groups = Kaminari.paginate_array(groups).page(params[:page])

    respond_to do |format|
      format.html
      format.json {render :json => groups}
    end
  end
end
