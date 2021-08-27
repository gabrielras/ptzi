# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET /orders' do
    let(:response_api) { { 'list' => { 'orders' => 'orders' } } }

    before do
      allow_any_instance_of(Pitzi::Orders).to receive(:list).and_return(response_api)
    end

    it 'returns orders' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /orders/new' do
    it 'return status 200 - :ok' do
      get :new

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /orders' do
    context 'with valid params' do
      let(:order_params) do
        {
          order: {
            imei: 448_674_528_976_410,
            annual_price: 1000,
            device_model: 'Iphone',
            installments: 4,
            user: {
              name: 'Name',
              cpf: '329.726.820-41',
              email: 'tes@tes.com'
            }
          }
        }
      end
      let(:response_api) { { 'order' => { 'id' => 'id' } } }

      before do
        allow_any_instance_of(Pitzi::Orders).to receive(:create).and_return(response_api)
      end

      it 'returns order' do
        post :create, params: order_params

        expect(response).to redirect_to '/orders'
      end
    end

    context 'with invalid params' do
      let(:order) { build(:order) }
      let(:order_params) do
        {
          order: {
            imei: order.imei,
            user: {
              name: 'Name'
            }
          }
        }
      end
      let(:response_api) { { 'errors' => { 'order' => 'error' } } }

      before do
        allow_any_instance_of(Pitzi::Orders).to receive(:create).and_return(response_api)
      end

      it 'returns order' do
        post :create, params: order_params

        expect(response).to redirect_to '/orders/new'
      end
    end
  end

  describe 'DELETE /orders/:id' do
    let(:response_api) { 1 }
    let(:order_params) { { id: '1' } }

    before do
      allow_any_instance_of(Pitzi::Orders).to receive(:destroy).and_return(response_api)
    end

    it 'returns order destroy' do
      delete :destroy, params: order_params

      expect(response).to redirect_to '/orders'
    end
  end
end
