# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pitzi::BaseAPI, type: :api do
  describe 'Mounted apps' do
    it 'mounts Pitzi::V1::BaseAPI app' do
      expect(described_class.routes.to_a).to include(*Pitzi::V1::BaseAPI.routes.to_a)
    end
  end
end
