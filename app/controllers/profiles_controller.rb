class ProfilesController < ApplicationController
  def show
    fetch_profile
    @post = @profile&.posts.new
    @posts = @profile&.posts.order(' created_at DESC')
  end

  def edit
    fetch_profile
  end

  def update
    fetch_profile
    if @profile.update(set_profile)
      redirect_to @profile, notice: 'Successfully updated'
    else
      render 'edit'
    end
  end

  def follow
    @profile = Profile.find(params[:profile_id])
    respond_to do |format|
      if current_user_profile.followed_profiles << @profile
        format.html { redirect_to @profile, notice: "Post was successfully created." }
      end
    end
  end

  def unfollow
    @profile = Profile.find(params[:profile_id])
    respond_to do |format|
      if current_user_profile.followed_profiles.destroy(@profile)
        format.html { redirect_to @profile, notice: "Post was successfully created." }
      end
    end
  end

  def liked_posts
    @profile = Profile.find(params[:profile_id])
    @posts = current_user_profile.posts

    render 'show'
  end

  private

  def fetch_profile
    @profile = Profile.find(params[:id])
  end

  def set_profile
    params.require(:profile).permit(:name, :description)
  end
end