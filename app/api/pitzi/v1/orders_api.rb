# frozen_string_literal: true

module Pitzi
  module V1
    class OrdersAPI < Grape::API
      get '/orders' do
        result = ::Orders::List.result

        present :list, result.list
      end

      params do
        requires :order, type: Hash do
          requires :annual_price, type: Integer
          requires :device_model, type: String
          requires :imei, type: Integer
          requires :installments, type: Integer

          optional :user_id, type: Integer

          given user_id: ->(val) { val.nil? } do
            requires :user, type: JSON do
              requires :name, type: String
              requires :email, type: String
              requires :cpf, type: String
            end
          end
        end
      end

      post '/orders' do
        order_params = declared(params, include_missing: false)[:order]
        result = ::Orders::Create.result(attributes: order_params)

        present :order, result.order
      end

      params do
        requires :id, type: String
      end

      delete '/orders/:id' do
        ::Orders::Destroy.result(id: params[:id])

        status :no_content
      end
    end
  end
end
