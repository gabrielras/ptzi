# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pitzi::V1::UsersAPI, type: :api do
  describe 'GET /v1/users' do
    let(:user) { create(:user) }

    before do
      allow(Users::List).to receive(:result)
        .and_return(ServiceActor::Result.new(list: [user]))
    end

    it 'returns users' do
      get '/api/v1/users'
      expected_response = { list: [user] }.to_json

      expect(response.body).to eq expected_response
    end

    it 'return status 200 - ok' do
      get '/api/v1/users'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /v1/users' do
    let(:user) { create(:user) }
    let(:user_params) { attributes_for(:user) }

    before do
      allow(Users::Create).to receive(:result)
        .with(attributes: user_params)
        .and_return(ServiceActor::Result.new(user: user))
    end

    it 'returns processed user' do
      post '/api/v1/users', params: { user: user_params }
      expected_response = { user: user }.to_json

      expect(response.body).to eq(expected_response)
    end

    it 'return status 201 - created' do
      post '/api/v1/users', params: { user: user_params }

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /v2/users/:id' do
    let(:user) { create(:user) }
    let(:user_params) { { user: { name: 'Teste User' } } }

    before do
      allow(Users::Update).to receive(:result)
        .with(id: user.id.to_s, attributes: user_params[:user])
        .and_return(ServiceActor::Result.new(user: user))
    end

    it 'returns updated user' do
      put "/api/v1/users/#{user.id}", params: user_params
      expected_response = { user: user }.to_json

      expect(response.body).to eq expected_response
    end

    it 'return status 200 - ok' do
      put "/api/v1/users/#{user.id}", params: user_params

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /v1/users/:id' do
    let(:user) { create(:user) }

    before do
      allow(Users::Destroy).to receive(:result)
        .with(id: user.id.to_s)
        .and_return(ServiceActor::Result.new)
    end

    it 'return status 204 - no_content' do
      delete "/api/v1/users/#{user.id}"

      expect(response).to have_http_status(:no_content)
    end
  end
end
