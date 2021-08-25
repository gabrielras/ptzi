# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::Create, type: :action do
  describe 'Inputs' do
    subject { described_class.inputs }

    it { is_expected.to include(attributes: { type: Hash }) }
  end

  describe 'Outputs' do
    subject { described_class.outputs }

    it { is_expected.to include(order: { type: Order }) }
  end

  describe '#call' do
    subject(:result) { described_class.result(attributes: attributes) }
    let(:user) { create(:user) }

    context 'when attributes are valid' do
      let(:attributes) do
        {
          imei: 448_674_528_976_410,
          annual_price: 1000,
          device_model: 'Iphone',
          installments: 4,
          user_id: user.id
        }
      end
      let(:user_params) { { user: user.attributes } }

      it { is_expected.to be_success }

      it 'creates order' do
        expect { result }.to change(Order.all, :count).by(1)
      end

      it 'creates order with given attribute' do
        expect(result.order.attributes).to include(
          'imei' => attributes[:imei],
          'annual_price' => attributes[:annual_price],
          'device_model' => attributes[:device_model],
          'installments' => attributes[:installments],
          'user_id' => attributes[:user_id]
        )
      end
    end

    context 'when attributes are valid' do
      let(:attributes) do
        {
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
      end

      it { is_expected.to be_success }

      it 'creates order' do
        expect { result }.to change(Order.all, :count).by(1)
      end

      it 'creates order with given attribute' do
        expect(result.order.attributes).to include(
          'imei' => attributes[:imei],
          'annual_price' => attributes[:annual_price],
          'device_model' => attributes[:device_model],
          'installments' => attributes[:installments]
        )
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { imei: 123_123_123_123 } }

      it { expect { result }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'when tier doesn`t exist' do
      let(:attributes) { {} }

      it { expect { result }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
