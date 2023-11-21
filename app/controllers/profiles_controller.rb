class ProfilesController < ApplicationController
  before_action :fetch_profile

  def show
    @profiles = Profile.all
    @post = @profile&.posts.new
    @posts = @profile&.posts.order('created_at DESC')
  end

  def edit;end

  def update
    if @profile.update(set_profile)
      redirect_to @profile, notice: 'Successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    fetch_object
    respond_to do |format|
      if @object.destroy
        format.turbo_stream { render :destroy, locals: { obj: @object} }
        format.html { redirect_to root_path, alert: 'Pomyślnie usunięto post' }
      else
        format.html { redirect_to root_path, notice: 'something went wrong' }
      end
    end
  end

  def follow
    respond_to do |format|
      if current_user_profile.followed_profiles << @profile
        format.html { redirect_to @profile, notice: "Post was successfully created." }
      end
    end
  end

  def unfollow
    respond_to do |format|
      if current_user_profile.followed_profiles.destroy(@profile)
        format.html { redirect_to @profile, notice: "Post was successfully created." }
      end
    end
  end

  def posts
    @pagy, @posts = pagy(@profile&.posts.order(created_at: :desc), items: 5)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def liked_posts
    @posts = ProfileService.new(@profile).get_likes
  end

  def comments
    @posts = ProfileService.new(@profile).get_comments
  end

  private

  def fetch_object
    @object = if params[:post_id]
                Post.find(params[:post_id])
              elsif params[:comment_id]
                Comment.find(params[:comment_id])
              end
  end

  def fetch_profile
    @profile = Profile.find(params[:id].present? ? params[:id] : params[:profile_id])
  end

  def set_profile
    params.require(:profile).permit(:name, :description)
  end
end