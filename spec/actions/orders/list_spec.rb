# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::List, type: :action do
  describe 'Inputs' do
    subject { described_class.inputs }

    it { is_expected.to be_empty }
  end

  describe 'Outputs' do
    subject { described_class.outputs }

    it { is_expected.to include(list: { type: Enumerable }) }
  end

  describe '#call' do
    subject(:result) { described_class.result }

    context 'when order exists' do
      let!(:order) { create(:order) }

      it { is_expected.to be_success }

      it 'returns order list' do
        expect(result.list).to eq([order])
      end
    end

    context 'when order doesn`t exist' do
      let!(:order) { Order.all.to_a }

      it 'returns order nil' do
        expect(result.list.to_a).to eq(order)
      end
    end
  end
end
