require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:valid_attributes) do
    { name: 'John Doe', email: 'john.doe@example.com', password: 'password123', password_confirmation: 'password123' }
  end
  let(:invalid_attributes) do
    { name: '', email: 'john.doe@example.com', password: 'password123', password_confirmation: 'password123' }
  end

  describe 'GET /api/v1/users' do
    before { get api_v1_users_path }

    it 'returns users' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(User.count)
    end
  end

  describe 'GET /api/v1/users/:id' do
    before { get api_v1_user_path(user_id) }

    context 'when the record exists' do
      it 'returns the user' do
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['id']).to eq(user_id)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'POST /api/v1/users' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    context 'when the request is valid' do
      before { post api_v1_users_path, params: valid_attributes, headers: auth_headers }

      it 'creates a user' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('John Doe')
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_users_path, params: invalid_attributes, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(JSON.parse(response.body)).to match('name' => ["can't be blank"])
      end
    end
  end

  describe 'PUT /api/v1/users/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    context 'when the record exists' do
      before { put api_v1_user_path(user_id), params: { name: 'Jane Doe' }, headers: auth_headers }

      it 'updates the record' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['name']).to eq('Jane Doe')
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 0 }
      before { put api_v1_user_path(user_id), params: { name: 'Jane Doe' }, headers: auth_headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:other_user) { create(:user) }

    context 'when logged out' do
      before { delete api_v1_user_path(other_user.id) }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when logged in' do
      before { delete api_v1_user_path(other_user.id), headers: auth_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success message' do
        expect(JSON.parse(response.body)['message']).to match('Usuario excluido com sucesso')
      end
    end
  end
end
