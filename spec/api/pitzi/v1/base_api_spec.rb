# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pitzi::V1::BaseAPI, type: :api do
  describe 'Configurations' do
    it 'has json format' do
      expect(described_class.format).to eq :json
    end

    it 'has v1 version' do
      expect(described_class.version).to eq :v1
    end

    it 'mounts Pitzi::V1::OrdersAPI app' do
      expect(described_class.routes.to_a).to include(*Pitzi::V1::OrdersAPI.routes.to_a)
    end

    it 'mounts Pitzi::V1::UsersAPI app' do
      expect(described_class.routes.to_a).to include(*Pitzi::V1::UsersAPI.routes.to_a)
    end
  end
end
