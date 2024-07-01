require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'GET /api/v1/posts/:post_id/comments' do
    context 'when there are posts' do
      let!(:comments) { create_list(:comment, 4) }
      let(:post_id) { comments.first.post_id }

      before { get api_v1_post_comments_path(post_id: post_id) }

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of all comments' do
        expect(JSON.parse(response.body).size).to eq(Comment.where(post_id: post_id).count)
      end

      it 'returns comments in the correct format' do
        comments = JSON.parse(response.body)
        expect(comments.first.keys).to match_array(%w[name comment created_at])
      end
    end

    context 'when posts is empty' do
      let!(:posts) { create_list(:post, 4) }
      let(:post_id) { posts.first.id }

      it 'returns an empty list of posts' do
        get api_v1_post_comments_path(post_id: post_id)

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('[]')
      end
    end
  end

  describe 'POST /api/v1/posts/:post_id/comments' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let!(:record_post) { create(:post, user: user) }
    let(:valid_params) { { name: 'Hello World', comment: 'My Comment', post_id: record_post.id } }
    let(:invalid_params) { { name: '', comment: '', post_id: nil } }

    context 'when logged out' do
      before do
        post api_v1_post_comments_path(record_post.id), params: valid_params
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      context 'with valid params' do
        before do
          sign_in user
        end

        it 'returns status created' do
          post api_v1_post_comments_path(record_post.id), params: valid_params, headers: auth_headers
          expect(response).to have_http_status(:created)
        end

        it 'creates a new comment' do
          expect { post api_v1_post_comments_path(record_post.id), params: valid_params, headers: auth_headers }.to change { record_post.comments.count }.by(1)
        end
      end

      context 'with invalid parameters' do
        before do
          sign_in user
        end

        it 'returns status unprocessable_entity' do
        post api_v1_post_comments_path(record_post.id), params: invalid_params, headers: auth_headers
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not create a new comment' do
          expect { post api_v1_post_comments_path(record_post.id), params: invalid_params, headers: auth_headers }.not_to change { record_post.comments.count }
        end
      end
    end
  end

  describe 'PATCH /api/v1/posts/:post_id/comments/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let!(:comments) { create_list(:comment, 4) }
    let(:post_id) { comments.first.post_id }
    let(:comment) { comments.first }
    let(:comment_id) { comments.first.id }
    let(:valid_params) { { name: 'Updated name', comment: 'Updated comment' } }

    context 'when logged out' do
      before { patch api_v1_post_comment_path(post_id, comment_id), params: valid_params }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when logged in' do
      before { sign_in user }

      context 'with valid params' do
        it 'returns status ok' do
          patch api_v1_post_comment_path(post_id, comment_id), params: valid_params, headers: auth_headers

          expect(response).to have_http_status(:ok)
        end

        it 'updates the comment' do
          patch api_v1_post_comment_path(post_id, comment_id), params: valid_params, headers: auth_headers
          comment.reload
          expect(comment.name).to eq('Updated name')
          expect(comment.comment).to eq('Updated comment')
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { { name: '', comment: '' } }

        it 'returns status unprocessable_entity' do
          patch api_v1_post_comment_path(post_id, comment_id), params: invalid_params, headers: auth_headers
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not update the comment' do
          patch api_v1_post_comment_path(post_id, comment_id), params: invalid_params, headers: auth_headers
          comment.reload
          expect(comment.name).not_to eq('')
          expect(comment.comment).not_to eq('')
        end
      end
    end
  end

  describe 'DELETE /api/v1/posts/:post_id/comments/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let!(:comments) { create_list(:comment, 4) }
    let(:post_id) { comments.first.post_id }
    let(:comment) { comments.first }
    let(:comment_id) { comments.first.id }

    context 'when logged out' do
      before { delete api_v1_post_comment_path(post_id, comment_id) }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when logged in' do
      before { sign_in user }

      it 'returns status no_content' do
        delete api_v1_post_comment_path(post_id, comment_id), headers: auth_headers
        expect(response).to have_http_status(:ok)
      end

      it 'deletes the post' do
        expect { delete api_v1_post_comment_path(post_id, comment_id), headers: auth_headers }.to change { Comment.where(post_id: post_id).count }.by(-1)
      end
    end
  end
end
