require 'rails_helper'

RSpec.describe "User's Posts", type: :feature do
  describe 'Index Page' do
    before(:each) do
      @user1 = User.create! name: 'Tom', photo: 'https://source.unsplash.com/user/c_v_r/100x100', bio: 'Tom bio'
      @post1 = Post.create! title: 'Post 1', text: 'Post content goes here', author_id: @user1.id
      @post2 = Post.create! title: 'Post 2', text: 'Post content goes here', author_id: @user1.id
      @post3 = Post.create! title: 'Post 3', text: 'Post content goes here', author_id: @user1.id
      @comment1 = Comment.create! text: 'Comment 1', author_id: @user1.id, post_id: @post1.id
      @comment2 = Comment.create! text: 'Comment 2', author_id: @user1.id, post_id: @post1.id
      @comment3 = Comment.create! text: 'Comment 3', author_id: @user1.id, post_id: @post2.id
      @like1 = Like.create! author_id: @user1.id, post_id: @post1.id
      @like2 = Like.create! author_id: @user1.id, post_id: @post1.id
      @like3 = Like.create! author_id: @user1.id, post_id: @post3.id

      visit user_posts_path(@user1)
    end

    it 'should see users profile picture' do
      expect(page).to have_xpath("//img[@src='#{@user1.photo}']")
    end

    it 'should see users username' do
      expect(page).to have_content(@user1.name)
    end

    it 'should see post title' do
      expect(page).to have_content(@post1.title)
    end

    it 'should see post body' do
      expect(page).to have_content(@post1.text)
    end

    it 'should see post comments' do
      expect(page).to have_content(@post1.comments.first.text)
    end

    it 'should see post number of comments' do
      expect(page).to have_content(@post1.comments.count)
    end

    it 'should see post number of likes' do
      expect(page).to have_content(@post1.likes.count)
    end
  end
end
