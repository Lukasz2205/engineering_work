class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :profile_unread_notifications

  def profile_unread_notifications
    return unless signed_in?

    @notifications_unread = Notification.recipient(current_user_profile).unread
  end

  def current_user_profile
    return unless signed_in?

    current_user.profile
  end
end