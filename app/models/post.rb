class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments
  has_many :likes

  after_save :update_post_counter

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end

  private

  def update_post_counter
    User.find(author_id).update(posts_counter: Post.where(author_id:).count)
  end
end
