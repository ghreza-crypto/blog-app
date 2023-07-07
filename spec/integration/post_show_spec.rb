require 'rails_helper'

RSpec.describe 'Specific Post', type: :feature do
  describe 'Show page' do
    before(:each) do
      @user1 = User.create! name: 'Tom', photo: 'https://source.unsplash.com/user/c_v_r/100x100', bio: 'Tom bio'
      @post1 = Post.create! title: 'Post 1', text: 'Post content goes here', author_id: @user1.id
      @comment1 = Comment.create! text: 'Comment 1', author_id: @user1.id, post_id: @post1.id
      @comment2 = Comment.create! text: 'Comment 2', author_id: @user1.id, post_id: @post1.id
      @comment3 = Comment.create! text: 'Comment 3', author_id: @user1.id, post_id: @post1.id
      @like1 = Like.create! author_id: @user1.id, post_id: @post1.id
      @like2 = Like.create! author_id: @user1.id, post_id: @post1.id

      visit user_post_path(@user1, @post1)
    end

    it 'should have post title' do
      expect(page).to have_content(@post1.title)
    end
    it 'should have post author' do
      expect(page).to have_content(@post1.author.name)
    end
    it 'should have post body' do
      expect(page).to have_content(@post1.text)
    end
    it 'should see comments username' do
      expect(page).to have_content(@comment1.author.name)
    end
    it 'should see comments content' do
      expect(page).to have_content(@comment1.text)
    end
  end
end
