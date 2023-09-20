class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :create_user_profile

  def create_user_profile
    return unless signed_in?
    Profile.find_or_create_by(user_id: current_user.id)
  end

  def current_user_profile
    current_user.profile
  end
end