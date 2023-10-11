require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'posts_controller' do
    context 'Get #index' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         post_counter: 3)
      Post.create(title: 'Hello World', author: user)
      it 'returns a 200 status code' do
        get user_posts_path(user)
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get user_posts_path(user)
        expect(response).to render_template(:index)
      end

      it 'shows tha body includes correct placeholder text' do
        get user_posts_path(user)
        expect(response.body).to include('Lists all posts for a specific user')
      end
    end

    context 'Get #show' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         post_counter: 3)
      post = Post.create(title: 'Hello World', author: user)
      it 'returns a 200 status code' do
        get user_post_path(user, post)
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        get user_post_path(user, post)
        expect(response).to render_template(:show)
      end

      it 'renders the show template' do
        get user_post_path(user, post)
        expect(response.body).to include('Shows a specific post for a specific user')
      end
    end
  end
end
