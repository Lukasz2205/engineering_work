class RoomsController < ApplicationController
  layout 'chatroom'

  def create
    @room = Room.create(name: params["room"]["name"])
  end

  def index
    @rooms = Room.public_rooms
    @profiles = Profile.all_except(current_user_profile)
  end

  def show
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @profiles = Profile.all_except(current_user_profile)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages.order('created_at ASC')

    render "index"
  end

  def private_chat
    @profile = Profile.find(params[:profile_id])
    @rooms = Room.public_rooms
    @users = Profile.all_except(current_user_profile)
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@profile, current_user_profile)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@profile, current_user_profile], @room_name)
    @messages = @single_room.messages

    render "index"
  end

  private

  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end
end