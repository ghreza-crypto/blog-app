class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(author_id: current_user.id, post_id: params[:post_id], **comment_params)
    if @comment.save
      flash[:notice] = 'Your comment was created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Sorry, something went wrong!'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment was successfully deleted.'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
