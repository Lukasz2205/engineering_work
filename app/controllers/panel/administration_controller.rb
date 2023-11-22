module Panel
  class AdministrationController < BaseController
    def index
    end

    def users
      @profiles = Profile.all
    end

    def posts
      @posts = Post.all.order(created_at: :desc).take(5)
    end
  end
end