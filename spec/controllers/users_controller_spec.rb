# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET /users' do
    let(:response_api) { { 'list' => { 'users' => 'users' } } }

    before do
      allow_any_instance_of(Pitzi::Users).to receive(:list).and_return(response_api)
    end

    it 'returns users' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /users/new' do
    it 'return status 200 - :ok' do
      get :new

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /users/:id/edit' do
    it 'return status 200 - :ok' do
      get :edit, params: { id: Faker::Lorem.word }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /users' do
    context 'with valid params' do
      let(:user) { build(:user) }
      let(:user_params) do
        {
          user: {
            name: user.name,
            cpf: user.cpf,
            email: user.email
          }
        }
      end
      let(:response_api) { { 'user' => { 'id' => 'id' } } }

      before do
        allow_any_instance_of(Pitzi::Users).to receive(:create).and_return(response_api)
      end

      it 'returns user' do
        post :create, params: user_params

        expect(response).to redirect_to '/users'
      end
    end

    context 'with invalid params' do
      let(:user) { build(:user) }
      let(:user_params) do
        {
          user: {
            name: user.name
          }
        }
      end
      let(:response_api) { { 'errors' => { 'user' => 'error' } } }

      before do
        allow_any_instance_of(Pitzi::Users).to receive(:create).and_return(response_api)
      end

      it 'returns user' do
        post :create, params: user_params

        expect(response).to redirect_to '/users/new'
      end
    end
  end

  describe 'PUT /users/:id' do
    context 'with valid params' do
      let(:user) { build(:user) }
      let(:user_params) do
        {
          id: '1',
          user: {
            name: user.name,
            cpf: user.cpf,
            email: user.email
          }
        }
      end
      let(:response_api) { { 'user' => { 'id' => 'id' } } }

      before do
        allow_any_instance_of(Pitzi::Users).to receive(:update).and_return(response_api)
      end

      it 'returns user' do
        put :update, params: user_params

        expect(response).to redirect_to '/users'
      end
    end

    context 'with invalid params' do
      let(:user) { build(:user) }
      let(:user_params) do
        {
          id: '1',
          user: {
            cpf: '1223'
          }
        }
      end
      let(:response_api) { { 'errors' => { 'user' => 'error' } } }

      before do
        allow_any_instance_of(Pitzi::Users).to receive(:update).and_return(response_api)
      end

      it 'returns user' do
        put :update, params: user_params

        expect(response).to redirect_to "/users/#{user_params[:id]}/edit"
      end
    end
  end

  describe 'DELETE /users/:id' do
    let(:response_api) { 1 }
    let(:user_params) { { id: '1' } }

    before do
      allow_any_instance_of(Pitzi::Users).to receive(:destroy).and_return(response_api)
    end

    it 'returns user destroy' do
      delete :destroy, params: user_params

      expect(response).to redirect_to '/users'
    end
  end
end
