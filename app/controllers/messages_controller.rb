class MessagesController < ApplicationController
  def create
    @message = current_user_profile.messages.new(content: msg_params[:content], room_id: params[:room_id])
    authorize @message
    @message.save
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end