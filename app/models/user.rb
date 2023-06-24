class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  validates :name, presence: true, length: { maximum: 100 }
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end
end
