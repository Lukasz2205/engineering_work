class ProfilesController < ApplicationController
  before_action :fetch_profile

  def show
    @post = @profile&.posts.new
    @posts = @profile&.posts.order(' created_at DESC')
  end

  def edit;end

  def update
    if @profile.update(set_profile)
      redirect_to @profile, notice: 'Successfully updated'
    else
      render 'edit'
    end
  end

  # def follow
  #   @profile = Profile.find(params[:id])
  #   current_user.profile.followees << @profile
  #   redirect_back(fallback_location: root_path)
  # end
  #
  # def unfollow
  #   @profile = Profile.find(params[:id])
  #   current_user.profile.followed_profiles.find_by(followee_id: @profile.id).destroy
  #   redirect_back(fallback_location: root_path)
  # end

  private

  def fetch_profile
    @profile = Profile.find(params[:id])
  end

  def set_profile
    params.require(:profile).permit(:name, :description)
  end
end