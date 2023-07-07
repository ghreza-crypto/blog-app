require 'rails_helper'

RSpec.describe 'Specific User', type: :feature do
  describe 'Show Page' do
    before(:each) do
      @user1 = User.create! name: 'Tom', photo: 'https://source.unsplash.com/user/c_v_r/100x100', bio: 'Tom bio'
      @user2 = User.create! name: 'Lilly', photo: 'https://i.picsum.photos/id/216/200/300.jpg?hmac', bio: 'Lilly bio'
      @post1 = Post.create! title: 'Post 1', text: 'Post content goes here', author_id: @user1.id
      @post2 = Post.create! title: 'Post 2', text: 'Post content goes here', author_id: @user1.id
      @post3 = Post.create! title: 'Post 3', text: 'Post content goes here', author_id: @user2.id
      visit user_path(@user1)
    end

    it 'should have user profile picture' do
      expect(page).to have_xpath("//img[@src='#{@user1.photo}']")
    end

    it 'should have user username' do
      expect(page).to have_content(@user1.name)
    end

    it 'should have user bio' do
      expect(page).to have_content(@user1.bio)
    end

    it 'should have user first 3 posts' do
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
    end
  end
end
