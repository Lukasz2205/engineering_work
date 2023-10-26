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
end
