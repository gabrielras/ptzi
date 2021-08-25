# frozen_string_literal: true

module Pitzi
  module V1
    class UsersAPI < Grape::API
      helpers do
        def user_params
          declared(params, include_missing: false)[:user]
        end
      end

      get '/users' do
        result = ::Users::List.result

        present :list, result.list
      end

      params do
        requires :user, type: Hash do
          requires :name, type: String
          requires :email, type: String
          requires :cpf, type: String
        end
      end

      post '/users' do
        result = ::Users::Create.result(attributes: user_params)

        present :user, result.user
      end

      params do
        requires :id, type: String
        requires :user, type: Hash do
          optional :name, type: String
          optional :email, type: String
          optional :cpf, type: String
        end
      end

      put '/users/:id' do
        result = ::Users::Update.result(id: params[:id], attributes: user_params)

        present :user, result.user
      end

      params do
        requires :id, type: String
      end

      delete '/users/:id' do
        ::Users::Destroy.result(id: params[:id])

        status :no_content
      end
    end
  end
end
