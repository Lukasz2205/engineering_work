class NotificationsService
  def initialize(sender, notifiable)
    @sender     = sender
    @recipient  = notifiable
    @notifiable = notifiable
  end

  def create_like_notification
    @notifiable.notifications.new(profile:    @sender,
                                  recipient:  @notifiable.profile,
                                  notifiable: @notifiable,
                                  text:       notification_text)
  end

  def create_comment_notification
    @notifiable.notifications.new(profile:    @sender,
                                  recipient:  @notifiable.profile,
                                  notifiable: @notifiable,
                                  text:       'Dodał komentarz!')
  end

  def create_reply_notification
    @notifiable.notifications.new(profile:    @sender,
                                  recipient:  @notifiable.profile,
                                  notifiable: @notifiable,
                                  text:       'Odpowiedział na twój komentarz!')
  end

  def create_block_notifications
    @notifiable.notifications.new(profile:    @sender,
                                  recipient:  @notifiable,
                                  notifiable: @notifiable,
                                  text:       'Zostałeś zablokowany!')
  end

  def create_unblock_notifications
    @notifiable.notifications.new(profile:    @sender,
                                  recipient:  @notifiable,
                                  notifiable: @notifiable,
                                  text:       'Zostałeś odblokowany!')
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