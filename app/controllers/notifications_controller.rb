class NotificationsController < ApplicationController
  def index
    @notifications_unread = Notification.recipient(current_user_profile).unread
    @notifications_read = Notification.recipient(current_user_profile).read
  end
end
