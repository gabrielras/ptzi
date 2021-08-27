# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pitzi::Users, type: :api do
  subject(:service) { described_class.new }

  describe 'Configurations' do
    it 'sets base api' do
      expect(described_class.base_uri).to eq 'http://localhost:3000/api/v1'
    end
  end

  describe '#list' do
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:get, "#{described_class.base_uri}/users").with(body: {})
                                                             .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns list' do
      response = service.list

      expect(response).to eq JSON.parse(request_response)
    end
  end

  describe '#create' do
    let(:user_params) { { key: 'value' } }
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:post, "#{described_class.base_uri}/users")
        .with(body: { user: user_params })
        .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'creates user' do
      response = service.create(user_params)

      expect(response).to eq JSON.parse(request_response)
    end
  end

  describe '#update' do
    let(:user_id) { Faker::Lorem.word }
    let(:user_params) { { key: 'value' } }
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:put, "#{described_class.base_uri}/users/#{user_id}")
        .with(body: { id: user_id, user: user_params  })
        .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'updates user' do
      response = service.update(user_id, user_params)

      expect(response).to eq JSON.parse(request_response)
    end
  end

  describe '#destroy' do
    let(:user_id) { Faker::Lorem.word }
    let(:request_response) { Hash[*Faker::Lorem.words(number: 4)].to_json }

    before do
      stub_request(:delete, "#{described_class.base_uri}/users/#{user_id}")
        .to_return(body: request_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'destroy user' do
      response = service.destroy(user_id)

      expect(response).to eq JSON.parse(request_response)
    end
  end
end
