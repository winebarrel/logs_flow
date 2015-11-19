class GroupsController < ApplicationController
  def index
    groups = Group.describe
    @groups = Kaminari.paginate_array(groups).page(params[:page])
  end
end
