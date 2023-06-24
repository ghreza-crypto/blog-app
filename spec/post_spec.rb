require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  end

  describe 'initialize' do
    before(:each) do
      @post = Post.new(author_id: @user.id, title: 'Hello', text: 'This is my first post')
    end

    it 'should be a Post' do
      expect(@post).to be_a(Post)
    end

    it 'should have the attributes' do
      expect(@post).to have_attributes(author_id: @user.id, title: 'Hello', text: 'This is my first post')
    end
  end

  describe 'validations' do
    before(:each) do
      @post = Post.new(author_id: @user.id, title: 'Hello', text: 'This is my first post')
      @post.save
    end

    it 'should validate presence of title' do
      expect(@post).to be_valid
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'should validate the length of title' do
      expect(@post).to be_valid
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end

    it 'should validate the numericality of comments_counter' do
      expect(@post).to be_valid
      @post.comments_counter = 'a'
      expect(@post).to_not be_valid
    end

    it 'should validate if comments_counter is greater than or equal to zero' do
      expect(@post).to be_valid
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end

    it 'should validate the numericality of likes_counter' do
      expect(@post).to be_valid
      @post.likes_counter = 'a'
      expect(@post).to_not be_valid
    end

    it 'should validate if likes_counter is greater than or equal to zero' do
      expect(@post).to be_valid
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end
  end

  describe 'methods' do
    before(:each) do
      @post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post')
    end

    it 'should return 5 recent comments' do
      Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my first comment')
      second_comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my second comment')
      third_comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my third comment')
      fourth_comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my fourth comment')
      fifth_comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my fifth comment')
      sixth_comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'This is my sixth comment')

      recent_comments = @post.recent_comments
      expect(recent_comments).to eq([sixth_comment, fifth_comment, fourth_comment, third_comment, second_comment])
    end

    it 'should update posts_counter of the user' do
      user_posts_counter = @user.posts_counter
      expect(user_posts_counter).to eq(0)

      @user.reload
      user_posts_counter = @user.posts_counter
      expect(user_posts_counter).to eq(1)
    end
  end
end
