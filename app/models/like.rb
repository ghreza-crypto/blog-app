class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true

  after_save :update_like_counter

  private

  def update_like_counter
    Post.find(post_id).update(likes_counter: Like.where(post_id:).count)
  end
end
