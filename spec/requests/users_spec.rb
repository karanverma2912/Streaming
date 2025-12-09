require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /signup' do
    context 'when params are correct' do
      it 'creates a new user and returns success' do
        post '/signup', params: {
          user: {
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password',
            username: 'testuser'
          }
        }

        expect(response).to have_http_status(:ok)
        expect(json['status']['code']).to eq(200)
        expect(json['data']['email']).to eq('test@example.com')
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'when params are incorrect' do
      it 'returns validation errors' do
        post '/signup', params: {
          user: {
            email: '',
            password: 'password'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST /login' do
    let!(:user) { User.create(email: 'test@example.com', password: 'password', username: 'testuser') }

    context 'with valid credentials' do
      it 'returns a JWT token' do
        post '/login', params: {
          user: {
            email: 'test@example.com',
            password: 'password'
          }
        }

        expect(response).to have_http_status(:ok)
        expect(response.headers['Authorization']).to be_present
        expect(json['status']['code']).to eq(200)
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized' do
        post '/login', params: {
          user: {
            email: 'test@example.com',
            password: 'wrongpassword'
          }
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /logout' do
    let!(:user) { User.create(email: 'test@example.com', password: 'password', username: 'testuser') }

    it 'logs out the user' do
      post '/login', params: {
        user: {
          email: 'test@example.com',
          password: 'password'
        }
      }
      token = response.headers['Authorization']

      delete '/logout', headers: { 'Authorization' => token }

      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('logged out successfully')
    end
  end

  def json
    JSON.parse(response.body)
  end
end
