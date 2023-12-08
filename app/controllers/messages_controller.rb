class MessagesController < ApplicationController
  def create
    @message = current_user_profile.messages.create(content: msg_params[:content], room_id: params[:room_id])
    respond_to do |format|
      render turbo_stream: turbo_stream.remove('info-message')
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end