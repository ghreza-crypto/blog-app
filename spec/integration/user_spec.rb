require 'rails_helper'

RSpec.describe 'User integration tests', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo1',
                         bio: 'Teacher from Mexico.', posts_counter: 4)
    @user2 = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo2',
                         bio: 'Teacher from Mexico.', posts_counter: 7)
    @user3 = User.create(name: 'Mary', photo: 'https://unsplash.com/photos/F_-0BxGuVvo3',
                         bio: 'Teacher from Mexico.', posts_counter: 2)
    @users = [@user1, @user2, @user3]
  end
  describe 'index' do
    before { visit users_path }
    it 'should display the username of all other users' do
      @users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'should display the profile picture for each user' do
      @users.each do |user|
        expect(page).to have_selector("img[src='#{user.photo}']")
      end
    end
    it 'should display the number of post for each user' do
      @users.each do |user|
        expect(page).to have_content("Number of posts: #{user.posts_counter}")
      end
    end
    it 'should redirect to the show user page when clicking on the user' do
      @users.each do |user|
        click_link(user.name)
        expect(page).to have_content(user.name)
        visit users_path
      end
    end
  end
  describe 'show' do
    before(:each) do
      @first_post = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my first post')
      @second_post = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my second post')
      @third_post = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my third post')
      @fourth_post = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my fourth post')
      @posts = [@second_post, @third_post, @fourth_post]
      visit user_path(@user1)
    end
    it 'should display the profile picture' do
      expect(page).to have_selector("img[src='#{@user1.photo}']")
    end
    it 'should display the username' do
      expect(page).to have_content(@user1.name)
    end
    it 'should display the number of post' do
      @user1.reload
      expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    end
    it 'should display the bio' do
      expect(page).to have_content(@user1.bio)
    end
    it 'should display the last 3 posts' do
      expect(page).to have_content(@second_post.text)
      expect(page).to have_content(@third_post.text)
      expect(page).to have_content(@fourth_post.text)
    end
    it 'should display a button to see all posts' do
      expect(page).to have_content('See all posts')
    end
    it 'should redirect to the posts index page when clicking on the see all posts button' do
      click_link('See all posts')
      expect(page).to have_content(@first_post.text)
      expect(page).to have_content(@second_post.text)
      expect(page).to have_content(@third_post.text)
      expect(page).to have_content(@fourth_post.text)
    end
  end
end