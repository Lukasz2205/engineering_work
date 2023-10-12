class LikesController < ApplicationController
  def create
    @likeable = find_likeable
    @like = @likeable.likes.build(profile: current_user_profile)

    respond_to do |format|
      if @like.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    respond_to do |format|
      if @like.destroy
        format.html { redirect_to root_path, notice: "Post was successfully created." }
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
