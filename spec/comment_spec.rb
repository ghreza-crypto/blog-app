require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post')
  end

  describe 'initialize' do
    before(:each) do
      @comment = Comment.new(post_id: @post.id, author_id: @user.id, text: 'This is my first comment')
    end

    it 'should be a Comment' do
      expect(@comment).to be_a(Comment)
    end

    it 'should have the attributes' do
      expect(@comment).to have_attributes(author_id: @user.id, post_id: @post.id,
                                          text: 'This is my first comment')
    end
  end

  describe 'methods' do
    it 'should update the comments_counter of the post' do
      post_comments_counter = @post.comments_counter
      expect(post_comments_counter).to eq(0)

      Comment.create(post_id: @post.id, author_id: @user.id, text: 'This is my first comment')
      @post.reload
      post_comments_counter = @post.comments_counter
      expect(post_comments_counter).to eq(1)
    end
  end
end
