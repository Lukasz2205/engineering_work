class HomeController < ApplicationController
  def index
    @post = Post.new
    # @comment = current_user.profile.comments.new

  end

  def index_lazy
    @posts = Post.all.order('created_at DESC')
  end
end
