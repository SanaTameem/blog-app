require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Get /users' do
    context 'Get #index' do
      it 'returns a 200 status code' do
        get users_path
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get users_path
        expect(response).to render_template(:index)
      end

      it 'shows that body includes correct placeholder text' do
        get users_path
        expect(response.body).to include('Lists all users')
      end
    end

    context 'Get #show' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         post_counter: 3)
      it 'returns a 200 status code' do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        get user_path(user)
        expect(response).to render_template(:show)
      end

      it 'renders the show template' do
        get user_path(user)
        expect(response.body).to include('Shows a specific user')
      end
    end
  end
end
