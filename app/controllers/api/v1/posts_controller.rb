class Api::V1::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = Post.all.includes(:comments)

    respond_to do |format|
      format.json { render json: @posts, status: 200 }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

    respond_to do |format|
      format.json { render json: @post, status: 200 }
    end
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post has benn created successfully'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:error] = 'Error: Post was not created !!'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(@user)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  private :post_params
end
