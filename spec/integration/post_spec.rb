require 'rails_helper'

RSpec.describe 'User integration tests', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo1',
                        bio: 'Teacher from Mexico.', posts_counter: 4)
    @commentor = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo2',
                             bio: 'Teacher from USA.')
    @first_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post')
    @second_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my second post')
    @third_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my third post')
    @fourth_post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my fourth post')
    @posts = [@first_post, @second_post, @third_post, @fourth_post]
    @first_comment = Comment.create(post_id: @first_post.id, author_id: @commentor.id, text: 'first comment')
    @second_comment = Comment.create(post_id: @first_post.id, author_id: @commentor.id, text: 'second_comment')
    @third_comment = Comment.create(post_id: @first_post.id, author_id: @commentor.id, text: 'third_comment')
    @fourth_comment = Comment.create(post_id: @first_post.id, author_id: @commentor.id, text: 'fourth_comment')
    @fifth_comment = Comment.create(post_id: @first_post.id, author_id: @commentor.id, text: 'fifth_comment')
    @sixth_comment = Comment.create(post_id: @first_post.id, author_id: @commentor.id, text: 'sixth_comment')
    @comments = [@first_comment, @second_comment, @third_comment, @fourth_comment, @fifth_comment, @sixth_comment]
  end
  describe 'index' do
    before { visit user_posts_path(@user) }
    it 'should display the profile picture of the user' do
      expect(page).to have_selector("img[src='#{@user.photo}']")
    end
    it 'should display the username of the user' do
      expect(page).to have_content(@user.name)
    end
    it 'should display the title of the last 3 post of the user' do
      expect(page).to have_content(@second_post.title)
      expect(page).to have_content(@third_post.title)
      expect(page).to have_content(@fourth_post.title)
    end
    it 'should display the text of the last 3 post of the user' do
      expect(page).to have_content(@second_post.text)
      expect(page).to have_content(@third_post.text)
      expect(page).to have_content(@fourth_post.text)
    end
    it 'should display the last 5 comments of a post' do
      @comments[1..].each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
    it 'should display the number of comments for each post' do
      @posts.each do |post|
        expect(page).to have_content("Comments: #{post.comments_counter}")
      end
    end
    it 'should display the number of likes for each post' do
      @posts.each do |post|
        expect(page).to have_content("Likes: #{post.likes_counter}")
      end
    end
    it 'should redirect to the post page when clicking on the view post link' do
      @posts.each do |post|
        post_link = find("a[href='#{user_post_path(@user.id, post.id)}']")
        post_link.click
        expect(page).to have_current_path(user_post_path(@user, post))
        visit user_posts_path(@user)
      end
    end
  end
  describe 'show' do
    before { visit user_post_path(@user, @first_post) }
    it 'should display post title' do
      expect(page).to have_content(@first_post.title)
    end
    it 'should display who wrote the post' do
      expect(page).to have_content(@user.name)
    end
    it 'should display the number of comments' do
      @first_post.reload
      expect(page).to have_content("Comments: #{@first_post.comments_counter}")
    end
    it 'should display the number of likes' do
      @first_post.reload
      expect(page).to have_content("Likes: #{@first_post.likes_counter}")
    end
    it 'should display the text of the post' do
      expect(page).to have_content(@first_post.text)
    end
    it 'should display the username of the author of each comment' do
      @comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end
    it 'should display each comment' do
      @comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
