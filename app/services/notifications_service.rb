class NotificationsService
  def initialize(sender, notifiable)
    @sender     = sender
    @recipient  = notifiable.profile
    @notifiable = notifiable
  end

  def create_notification
    @notifiable.notifications.new(profile:    @sender,
                                  recipient:  @notifiable.profile,
                                  notifiable: @notifiable,
                                  text:       notification_text)
  end

  private

  def notification_text
    if @notifiable.class == Post
      'Polubił twój post!'
    else
      'Polubił twój Komentarz!'
    end
  end
end