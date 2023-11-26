class NotificationsService
  def initialize(sender, object)
    @sender   = sender
    @object   = object
  end

  def create_notification
    puts 'hehehe'
    puts @sender.inspect
    puts @object.inspect
    @notification = @object.profile.notifications.new(assigned_by: @sender, object: @object)
    # puts @notification
  end
end