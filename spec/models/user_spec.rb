require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                  post_counter: 3)

  describe 'User model' do
    context 'Validations when checking name' do
      it 'Should return not valid for a blank name' do
        user.name = nil
        expect(user).to_not be_valid
      end

      it 'Should return valid for an existing name' do
        user.name = 'Tom'
        expect(user).to be_valid
      end
    end

    context 'Validations when checking post_counter' do
      it 'Should not allow a non integer post_counter' do
        user.post_counter = 'Something'
        expect(user).to_not be_valid
      end

      it 'Should allow an integer post_counter' do
        user.post_counter = 7
        expect(user).to be_valid
        user.post_counter = 0
        expect(user).to be_valid
      end

      it 'Should not allow an integer lower than 0' do
        user.post_counter = -1
        expect(user).to_not be_valid
      end
    end

    context 'User Method: #recent_posts' do
      it 'return the recent three posts for a user' do
        first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                 bio: 'Teacher from Mexico.')

        first_post = Post.create(author: first_user, title: 'First', text: 'First Post', created_at: 4.day.ago)
        second_post = Post.create(author: first_user, title: 'Second', text: 'Second Post', created_at: 3.day.ago)
        third_post = Post.create(author: first_user, title: 'Third', text: 'Third Post', created_at: 2.day.ago)
        fourth_post = Post.create(author: first_user, title: 'Fourth', text: 'Fourth Post', created_at: 1.day.ago)

        recent_posts = first_user.recent_posts

        expect(recent_posts).to eq([fourth_post, third_post, second_post])
        expect(recent_posts).to_not include(first_post)
      end
    end
  end
end
