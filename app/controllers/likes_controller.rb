class LikesController < ApplicationController
  def create
    @like = Like.new(author_id: current_user.id, post_id: params[:post_id])
    if @like.save
      flash[:notice] = 'Your like was created successfully'
    else
      flash[:alert] = 'Sorry, something went wrong!'
    end
    redirect_to user_posts_path(params[:user_id])
  end
end
