# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::Destroy, type: :action do
  describe 'Inputs' do
    subject { described_class.inputs }

    it { is_expected.to include(id: { type: String }) }
  end

  describe 'Outputs' do
    subject { described_class.outputs }

    it { is_expected.to be_empty }
  end

  describe '#call' do
    subject(:result) { described_class.result(id: order_id) }

    context 'when order doesn`t exist' do
      let(:order_id) { 'error' }

      it { expect { result }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'when order exists' do
      let(:order) { create(:order) }
      let(:order_id) { order.id.to_s }

      it { is_expected.to be_success }

      it 'destroys order' do
        result

        expect { order.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
