class HomeController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def index_lazy
    @pagy, @posts = pagy(Post.all.order('created_at DESC'), items: 5)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
