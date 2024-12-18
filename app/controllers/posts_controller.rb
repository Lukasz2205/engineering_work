class PostsController < ApplicationController
  layout 'layouts/post'

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.profile.posts.build(description: params[:post][:description], attachments: params[:post][:attachments])
    authorize @post
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
        format.turbo_stream { render :create, locals: { post: @post, notice: "Pomyślnie utworzono nowy wpis!"  } }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render root_path, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity, locals: { post_id: nil, alert: @post.errors.messages } }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:description))
      redirect_to post_path(@post), notice: 'Pomyślnie zaktualizowano post!'
    else
      redirect_to root_path, alert: 'Coś poszło nie tak'
    end
  end

  def destroy
    puts 'zxczxczxczx'
    puts request.headers['Content-Type']
    @post = Post.find(params[:id])
  rescue StandardError
    respond_to do |format|
      format.turbo_stream do
        render :clear, status: :unprocessable_entity, locals: { object_id: params[:id], alert: 'Nie odnaleziono wybranego obiektu!' }
      end
    end
  else
    authorize @post
    respond_to do |format|
      # if @post.destroy
        format.turbo_stream do
          render :destroy, locals: { post: @post, notice: 'Pomyślnie usunięto obiekt!' }
        end
        format.html { redirect_to root_path, notice: 'Pomyślnie usunięto obiekt!' }
      # end
    end
  end

  def fetch_comments
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
  end

  private

  def set_post
    params.require(:post).permit(:description, attachments: [])
  end
end