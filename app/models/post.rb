class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: { message: 'Title cannot be blank' }, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  after_save :update_post_counter
  after_destroy :update_posts_counter

  def author
    User.find(author_id)
  end

  def recent_comments
    comments.order('created_at Desc').limit(5)
  end

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
