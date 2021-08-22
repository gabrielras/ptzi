# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:imei) }
    it { is_expected.to validate_presence_of(:annual_price) }
    it { is_expected.to validate_presence_of(:device_model) }
    it { is_expected.to validate_presence_of(:installments) }
    it { is_expected.to validate_presence_of(:user_id) }

    it { is_expected.to validate_numericality_of(:annual_price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:installments).is_less_than(13) }
    it { is_expected.to validate_numericality_of(:installments).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:imei).is_greater_than(0) }

    context 'when the imei is valid' do
      subject(:order) { described_class.new(imei: 448_674_528_976_410) }

      it 'doesn`t add invalid imei error message' do
        order.valid?

        expect(order.errors[:imei]).to be_empty
      end
    end

    context 'when the imei is invalid' do
      subject(:order) { described_class.new(imei: 35_780_502_398_494) }

      it 'adds invalid imei error message' do
        order.valid?

        error_message = 'imei is not a valid number'
        expect(order.errors[:imei]).to include error_message
      end
    end

    subject { create(:order) }
    it { is_expected.to validate_uniqueness_of(:imei).case_insensitive }
  end
end
