class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end
  def new
    @post = Post.new
  end

  def create
    @post = current_user.profile.posts.build(
      description: params[:post][:description])
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
        format.turbo_stream { render :create, locals: { post: @post } }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render root_path, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity, locals: { post: @post } }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(profile: current_user_profile, object_type: @post.class.to_s)
    respond_to do |format|
      if @like.save
        format.turbo_stream { render :unlike, locals: { post: @post } }
      else
        redirect_to root_path, alert: 'something went wrong'
      end
    end

  end

  def unlike
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(profile_id: current_user_profile.id)
    respond_to do |format|
      if @like.destroy
        format.turbo_stream { render :like, locals: { post: @post } }
      else
        redirect_to root_path, alert: 'something went wrong'
      end
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: 'Pomyślnie usunięto posts'
  end

  private

  def set_post
    params.require(:post).permit(:description, attachments: [])
  end
end