class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])

    begin
      @post = Post.where(author_id: @user.id).find(params[:id])
    rescue StandardError
      @post = nil
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(author_id: current_user.id, **post_params)

    if @post.save
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Sorry, something went wrong!'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
