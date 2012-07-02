class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_current_user

  filter_access_to :all

  protect_from_forgery

protected
  def set_current_user
    Authorization.current_user = current_user
  end
end
