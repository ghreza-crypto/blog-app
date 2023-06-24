require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                     posts_counter: 0)
  end

  describe 'initialize' do
    it 'should be a User' do
      expect(@user).to be_a(User)
    end

    it 'should have the attributes' do
      expect(@user).to have_attributes(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                       bio: 'Teacher from Mexico.', posts_counter: 0)
    end
  end

  describe 'validations' do
    before { @user.save }

    it 'should validate presence of name' do
      expect(@user).to be_valid
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'should validate numericality of posts_counter' do
      expect(@user).to be_valid
      @user.posts_counter = 'a'
      expect(@user).to_not be_valid
    end

    it 'should validate if posts_counter is greater than or equal to zero' do
      expect(@user).to be_valid
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end
  end

  describe 'methods' do
    it 'should return 3 recent posts' do
      @user.save

      Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post')
      second_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my second post')
      third_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my third post')
      fourth_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my fourth post')

      recent_posts = @user.recent_posts
      expect(recent_posts).to eq([fourth_post, third_post, second_post])
    end
  end
end