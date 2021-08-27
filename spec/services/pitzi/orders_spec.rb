# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pitzi::Orders, type: :api do
  subject(:service) { described_class.new }

  describe 'Configurations' do
    it 'sets base api' do
      expect(described_class.base_uri).to eq 'http://localhost:3000/api/v1'
    end
  end

  describe '#list' do
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:get, "#{described_class.base_uri}/orders")
        .with(body: {})
        .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns list' do
      response = service.list

      expect(response).to eq JSON.parse(request_response)
    end
  end

  describe '#create' do
    let(:order_params) { { key: 'value' } }
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:post, "#{described_class.base_uri}/orders")
        .with(body: { order: order_params })
        .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'creates order' do
      response = service.create(order_params)

      expect(response).to eq JSON.parse(request_response)
    end
  end

  describe '#destroy' do
    let(:order_id) { Faker::Lorem.word }
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:delete, "#{described_class.base_uri}/orders/#{order_id}")
        .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'destroy order' do
      response = service.destroy(order_id)

      expect(response).to eq JSON.parse(request_response)
    end
  end
end
