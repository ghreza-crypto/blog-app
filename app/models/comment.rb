class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comment_counter
  after_destroy :update_comments_counter

  def author
    User.find(author_id)
  end

  private

  def update_comment_counter
    post.increment!(:comments_counter)
  end
end
