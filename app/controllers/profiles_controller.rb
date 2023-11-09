class ProfilesController < ApplicationController
  before_action :fetch_profile

  def show
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
    @posts = @profile&.posts.order(' created_at DESC')

    render 'show'
  end

  def liked_posts
    @posts = ProfileService.new(@profile).get_likes

    render 'show'
  end

  def comments
    @posts = ProfileService.new(@profile).get_comments
    puts 'hehehesd'
    puts @posts
    render 'show'
  end

  private

  def fetch_profile

    @profile = Profile.find(params[:id].present? ? params[:id] : params[:profile_id])
  end

  def set_profile
    params.require(:profile).permit(:name, :description)
  end
end