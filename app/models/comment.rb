class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true

  after_save :update_post_counter


  private

  def update_comment_counter
    Post.find(post_id).update(comments_counter: Comment.where(post_id:).count)
  end
end
