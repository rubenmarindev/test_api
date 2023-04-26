require 'rails_helper'
require 'byebug'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    before { get '/posts' }

    it 'returns OK' do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe 'with data in the DB' do
    let!(:posts) { create_list(:post, 10, published: true) }
    before { get '/posts'}

    it 'should return all the published posts' do
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /post/{id}' do
    let!(:post) { create(:post) }

    it 'should return a post' do
      get "/posts/#{post.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(post.id)
      expect(payload['title']).to eq(post.title)
      expect(payload['content']).to eq(post.content)
      expect(payload['published']).to eq(post.published)
      expect(payload['author']['name']).to eq(post.user.name)
      expect(payload['author']['email']).to eq(post.user.email)
      expect(payload['author']['id']).to eq(post.user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /posts/' do
    let(:user) { create(:user) }
    let(:request) do
      { post: {
        title: 'Post to test creation',
        content: 'Post created to test the creation using http method POST',
        published: true,
        user_id: user.id
      } }
    end

    it 'creates a new post' do
      post '/posts', params: request
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['id']).not_to be_nil
      expect(response).to have_http_status(:created)
    end

    it 'returns a error message on invalid post' do
      request[:post][:title] = nil

      post '/posts', params: request
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['error']).not_to be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /posts/{id}' do
    let(:post_to_update) { create(:post) }
    let(:request) do
      { post: {
        title: 'Post to test editing',
        content: 'Post created to test the edition using http method POST',
        published: true
      } }
    end

    it 'updates a post' do
      put "/posts/#{post_to_update[:id]}", params: request
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['id']).to eq(post_to_update.id)
      expect(response).to have_http_status(:ok)
    end

    it 'returns an error updating an invalid post' do
      request[:post][:title] = nil
      request[:post][:content] = nil
      request[:post][:published] = nil

      put "/posts/#{post_to_update[:id]}", params: request
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['error']).not_to be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
