class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_region

  private

  def set_region
    if params[:region]
      @region = params[:region]
    else
      @region = Rails.application.config.default_region
    end

    Aws.config.update(region: @region)
  end
end
