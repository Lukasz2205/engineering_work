class CommentsController < ApplicationController
  def create
    @post            = Post.find(params[:post_id])
    @comment         = @post.comments.new(set_comment)
    @comment.profile = current_user_profile

    respond_to do |format|
      @notification = NotificationsService.new(current_user_profile, @post).create_comment_notification
      @notification.save
      if @comment.save
        format.turbo_stream { render :create, locals: { post: @post, comment: @comment} }
      else
        format.html { redirect_to root_path, alert: 'Something went wrong' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.turbo_stream
        format.html { redirect_to root_path, notice: 'Pomyślnie usunięto posts' }
      else
        format.html { redirect_to root_path, alert: 'Something went wrong' }
      end
    end
  end

  def reply
    @comment       = Comment.find(params[:comment_id])
    @post          = @comment.post
    @reply         = @comment.replies.new(set_comment)
    @reply.profile = current_user_profile
    respond_to do |format|
      @notification = NotificationsService.new(current_user_profile, @comment).create_reply_notification
      @notification.save
      if @reply.save
        format.turbo_stream { render :reply, locals: { reply: @reply, comment: @comment } }
      end
    end
  end

  def show_comment
    @comment = Comment.find(params[:comment_id])
    respond_to do |format|
      format.turbo_stream { render :show_comment, locals: { comment: @comment } }
    end
  end

  def hide_comment
    @comment = Comment.find(params[:comment_id])
    respond_to do |format|
      format.turbo_stream { render :hide_comment, locals: { comment: @comment } }
    end
  end

  private

  def set_comment
    params.require(:comment).permit(:message)
  end
end