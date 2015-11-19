class WelcomeController < ApplicationController
  def index
    redirect_to groups_path(region: params[:region])
  end
end
