class ProfilesController < ApplicationController
  before_action :fetch_profile, except: [:edit, :update]
  before_action lambda {
    resize_before_save(params[:profile][:avatar], 48, 48)
  }, only: [:update]

  layout 'layouts/profile'

  def new

  end

  def create
    @profile.create(params.require(:profile).permit(:id, :name, :description, :user_id, ))
  end
  def show
    @profiles = Profile.all
    @post = @profile&.posts.new
    @posts = @profile&.posts.order('created_at DESC')
  end

  def edit
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
    authorize @profile
    if @profile.update(set_profile)
      redirect_to @profile, notice: 'Successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    fetch_object
  rescue StandardError => e
    respond_to do |format|
      format.turbo_stream do
        render :clear, status: :unprocessable_entity, locals: { object_id: e.id, alert: 'Nie odnaleziono wybranego obiektu!' }
      end
    end
  else
    respond_to do |format|
      if @object.destroy
        format.turbo_stream do
          render :destroy, locals: { obj: @object, notice: 'Pomyślnie usunięto obiekt!' }
        end
      end
    end
  end

  def follow
    respond_to do |format|
      if current_user.profile.followees << @profile
        format.html { redirect_to @profile, notice: "Post was successfully created." }
      end
    end
  end

  def unfollow
    respond_to do |format|
      if  current_user.profile.followed_profiles.find_by(followee_id: @profile.id).destroy
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

  def resize_before_save(image_param, width, height)
    return unless image_param

    begin
      ImageProcessing::MiniMagick
              .source(image_param)
              .resize_to_fit(width, height)
              .call(destination: image_param.tempfile.path)
      puts 'Image has been resized successfully'
    rescue StandardError => e
      puts "Error resizing image: #{e.message}"
      # Do nothing. If this is catching, it probably means the
      # file type is incorrect, which can be caught later by
      # model validations.
    end
  end

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
    params.require(:profile).permit(:name, :description, :avatar)
  end
end