# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pitzi::V1::OrdersAPI, type: :api do
  describe 'GET /v1/orders' do
    let(:order) { create(:order) }

    before do
      allow(Orders::List).to receive(:result)
        .and_return(ServiceActor::Result.new(list: [order]))
    end

    it 'returns orders' do
      get '/api/v1/orders'
      expected_response = { list: [order] }.to_json

      expect(response.body).to eq expected_response
    end

    it 'return status 200 - ok' do
      get '/api/v1/orders'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /orders' do
    let(:order) { build(:order, user: create(:user)) }
    let(:order_params) do
      {
        'annual_price' => 1000,
        'device_model' => 'Iphone',
        'imei' => 448_674_528_976_410,
        'installments' => 12,
        'user_id' => 1
      }
    end

    before do
      allow(Orders::Create).to receive(:result)
        .with(attributes: order_params)
        .and_return(ServiceActor::Result.new(order: order))
    end

    context 'when the user_id is present' do
      it 'returns processed order' do
        post '/api/v1/orders', params: { order: order_params }
        expected_response = { order: order }.to_json

        expect(response.body).to eq(expected_response)
      end

      it 'return status 201 - created' do
        post '/api/v1/orders', params: { order: order_params }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when the user_id isn`t present' do
      before do
        order_params.except(:user_id).merge(
          {
            'user' => {
              'name' => 'User Test',
              'email' => 'test@teste.com',
              'cpf' => '329.726.820-41'
            }
          }
        )
      end

      it 'returns processed order' do
        post '/api/v1/orders', params: { order: order_params }
        expected_response = { order: order }.to_json

        expect(response.body).to eq(expected_response)
      end

      it 'return status 201 - created' do
        post '/api/v1/orders', params: { order: order_params }

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'DELETE /v1/orders/:id' do
    let(:order) { create(:order) }

    before do
      allow(Orders::Destroy).to receive(:result)
        .with(id: order.id.to_s)
        .and_return(ServiceActor::Result.new)
    end

    it 'return status 204 - no_content' do
      delete "/api/v1/orders/#{order.id}"

      expect(response).to have_http_status(:no_content)
    end
  end
end
