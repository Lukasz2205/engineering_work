module Panel
  class AdministrationController < BaseController
    def index
      @pagy, @posts = pagy(Post.all.order('created_at DESC'), items: 5)
    end

    def users
      @profiles = Profile.all
    end

    def posts
      @pagy, @posts = pagy(Post.all.order('created_at DESC'), items: 5)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end
  end
end