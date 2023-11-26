class LikesController < ApplicationController
  def create
    @likeable = find_likeable
    @like = @likeable.likes.build(profile: current_user_profile)

    respond_to do |format|
      if @like.save
        @notification = NotificationsService.new(current_user_profile, @likeable).create_notification
        @notification.save
        format.turbo_stream { render :create, locals: { p: @likeable } }
      else
        format.html { redirect_to root_path, alert: 'Something went wrong' }
      end
    end
  end

  def destroy
    @likeable = find_likeable
    @like = Like.find(params[:id])

    if @like.destroy
      respond_to do |format|
        format.turbo_stream { render :destroy, locals: { p: @likeable } }
      end
    end
  end

  private

  def find_likeable
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end

  def set_like
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
