class HomeController < ApplicationController
  def index
    @post = Post.new
    # @comment = current_user.profile.comments.new
    @posts = Post.all.order('created_at DESC')
  end
end
