class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end
end
