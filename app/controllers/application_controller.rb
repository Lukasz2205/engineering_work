class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!
  before_action :profile_unread_notifications

  private
  def user_not_authorized
    flash[:alert] = "Odmowa dostępu!"
    redirect_back(fallback_location: root_path)
  end

  def profile_unread_notifications
    return unless signed_in?

    @notifications_unread = Notification.recipient(current_user_profile).unread
  end

  def current_user_profile
    return unless signed_in?

    current_user.profile
  end
end