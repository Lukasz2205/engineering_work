class HomeController < ApplicationController
  def index
    @post = Post.new
  end

  def index_lazy
    @posts = Post.all.order('created_at DESC')
  end
end
