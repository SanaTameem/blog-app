require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(name: 'John Doe')
  end

  let(:myPost) do
    Post.new(
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 3,
      likes_counter: 1,
      author: user
    )
  end

  describe 'Validations' do
    context 'when checking post title' do
      it 'Should return not valid for a blank title' do
        myPost.title = nil
        expect(myPost).to_not be_valid
      end

      it 'Should return not valid for a title more than 250 chars' do
        myPost.title = 'Lorem' * 60

        expect(myPost).to_not be_valid
      end
    end

    context 'when checking comments_counter' do
      it 'Should say not valid for non integer value of comment_counter' do
        myPost.comments_counter = 'Something'
        expect(myPost).to_not be_valid
      end

      it 'Should say valid for an integer value of comment_counter' do
        myPost.comments_counter = 0
        expect(myPost).to be_valid
      end

      it 'Should say not valid for a value less than 0 for comment_counter' do
        myPost.comments_counter = -3
        expect(myPost).to_not be_valid
      end
    end

    context 'when checking likes_counter' do
      it 'Should say not valid for non integer value of like_counter' do
        myPost.likes_counter = 'Something'
        expect(myPost).to_not be_valid
      end

      it 'Should say valid for an integer value of like_counter' do
        myPost.likes_counter = 0
        expect(myPost).to be_valid
      end

      it 'Should say not valid for a value less than 0 for like_counter' do
        myPost.likes_counter = -3
        expect(myPost).to_not be_valid
      end
    end
  end

  describe 'Methods of post.rb' do
    it 'Should update post_counter when a new post is created' do
      user = User.create(name: 'Sana')
      post = Post.create(title: 'Hello World', author: user)

      post.update_posts_counter

      expect(user.post_counter).to eq(1)
    end

    it 'Should show the 5 recent comments of a post' do
      first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Mexico.')
      first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
      comment1 = Comment.create(post: first_post, user: first_user, text: 'Hi There!', created_at: 6.hours.ago)
      comment2 = Comment.create(post: first_post, user: first_user, text: 'Hello There!', created_at: 5.hours.ago)
      comment3 = Comment.create(post: first_post, user: first_user, text: 'This is Sana!', created_at: 4.hours.ago)
      comment4 = Comment.create(post: first_post, user: first_user, text: 'Coding is challanging!',
                                created_at: 3.hours.ago)
      comment5 = Comment.create(post: first_post, user: first_user, text: 'But practice!', created_at: 2.hours.ago)
      comment6 = Comment.create(post: first_post, user: first_user, text: 'Bye!', created_at: 1.hours.ago)
      expect(first_post.five_recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
      expect(first_post.five_recent_comments).to_not include(comment1)
    end
  end
end
