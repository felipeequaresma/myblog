require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /api/v1/posts' do
    context 'when there are posts' do
      let!(:posts) { create_list(:post, 4) }

      before { get api_v1_posts_path }

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of all posts' do
        expect(JSON.parse(response.body).size).to eq(Post.count)
      end

      it 'returns posts in the correct format' do
        posts = JSON.parse(response.body)
        expect(posts.first.keys).to match_array(%w[id title text created_at author])
      end

      context 'with author' do
        let!(:post_with_author) { create(:post, user: create(:user)) }

        before { get api_v1_posts_path }

        it 'returns authors in the correct format' do
          posts = JSON.parse(response.body)
          expect(posts.first['author'].keys).to match_array(%w[id name])
        end
      end
    end
  end

  describe 'GET /api/v1/posts/:id' do
    context 'when the post exists' do
      let!(:post) { create(:post) }

      before { get api_v1_post_path(post.id) }

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the post in the correct format' do
        post_response = JSON.parse(response.body)
        expect(post_response.keys).to match_array(%w[id title text created_at author comments])
      end
    end

    context 'when the post does not exist' do
      before { get api_v1_post_path(123456) }

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/posts' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:valid_params) { { text: 'Hello World', title: 'My Post', user_id: user.id } }
    let(:invalid_params) { { text: '', title: '', user_id: nil } }

    context 'when logged out' do
      before { post api_v1_posts_path, params: valid_params }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      context 'with valid params' do
        before do
          sign_in user
        end

        it 'returns status created' do
          post api_v1_posts_path, params: valid_params, headers: auth_headers
          expect(response).to have_http_status(:created)
        end

        it 'creates a new post' do
          expect { post api_v1_posts_path, params: valid_params, headers: auth_headers }.to change { Post.count }.by(1)
        end
      end

      context 'with invalid parameters' do
        before do
          sign_in user
        end

        it 'returns status unprocessable_entity' do
        post api_v1_posts_path, params: invalid_params, headers: auth_headers
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not create a new post' do
          expect { post api_v1_posts_path, params: invalid_params, headers: auth_headers }.not_to change { Post.count }
        end
      end
    end
  end

  describe 'PATCH /api/v1/posts/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:post) { create(:post, user: user) }
    let(:valid_params) { { text: 'Updated text', title: 'Updated title' } }

    context 'when logged out' do
      before { patch api_v1_post_path(post.id), params: valid_params }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when logged in' do
      before { sign_in user }

      context 'with valid params' do
        it 'returns status ok' do
          patch api_v1_post_path(post.id), params: valid_params, headers: auth_headers
          expect(response).to have_http_status(:ok)
        end

        it 'updates the post' do
          patch api_v1_post_path(post.id), params: valid_params, headers: auth_headers
          post.reload
          expect(post.text).to eq('Updated text')
          expect(post.title).to eq('Updated title')
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { { text: '', title: '' } }

        it 'returns status unprocessable_entity' do
          patch api_v1_post_path(post.id), params: invalid_params, headers: auth_headers
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not update the post' do
          patch api_v1_post_path(post.id), params: invalid_params, headers: auth_headers
          post.reload
          expect(post.text).not_to eq('')
          expect(post.title).not_to eq('')
        end
      end
    end
  end

  describe 'DELETE /api/v1/posts/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let!(:post) { create(:post, user: user) }

    context 'when logged out' do
      before { delete api_v1_post_path(post.id) }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when logged in' do
      before { delete api_v1_post_path(post.id), headers: auth_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'deletes the post' do
        expect(JSON.parse(response.body)['message']).to match('Post excluido com sucesso')
      end
    end
  end
end
