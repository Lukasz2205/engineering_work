class CommentsController < ApplicationController
  def create
    @post            = Post.find(params[:post_id])
    @comment         = @post.comments.new(set_comment)
    @comment.profile = current_user_profile

    respond_to do |format|
      if @comment.save
        format.turbo_stream { render :create, locals: { comment: @comment, post: @post } }
      else
        format.html { redirect_to root_path, alert: 'something went wrong' }
      end
    end
  end

  private

  def set_comment
    params.require(:comment).permit(:message)
  end
end