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

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.turbo_stream
        format.html { redirect_to root_path, alert: 'Pomyślnie usunięto post' }
      else
        format.html { redirect_to root_path, notice: 'something went wrong' }
      end
    end
  end

  private

  def set_post
    params.require(:post).permit(:description, attachments: [])
  end
end