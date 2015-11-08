class GroupsController < ApplicationController
  def index
    @groups = Group.describe
  end
end
