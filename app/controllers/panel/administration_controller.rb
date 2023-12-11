module Panel
  class AdministrationController < BaseController
    before_action :authorization
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

    private
    def authorization
      unless AdministrationPolicy.new(current_user).is_admin?
        redirect_to root_path, alert: "Odmowa dostępu!"
      end
    end
  end
end