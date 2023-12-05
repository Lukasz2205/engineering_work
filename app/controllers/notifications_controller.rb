class NotificationsController < ApplicationController
  before_action :fetch_notifications

  def index;end

  def read_all
    @notifications_unread.each do |notif|
      notif.update(read: true)
    end
    redirect_to notifications_path
  end

  private

  def fetch_notifications
    @notifications_unread = Notification.recipient(current_user_profile).unread
    @notifications_read = Notification.recipient(current_user_profile).read
  end
end
