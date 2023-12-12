module Panel
  class AdministrationController < BaseController
    before_action :authorize_role
    def index
      @pagy, @posts = pagy(Post.all.order('created_at DESC'), items: 5)
    end

    def users
      @profiles = Profile.all.order(name: :asc)
    end

    def posts
      @pagy, @posts = pagy(Post.all.order('created_at DESC'), items: 5)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    private

    def authorize_role
      authorize current_user, :is_admin?
    end
    def authorization
      UserPolicy.new(current_user).is_admin?
    end
  end
end