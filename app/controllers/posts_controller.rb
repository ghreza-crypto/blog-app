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
end
