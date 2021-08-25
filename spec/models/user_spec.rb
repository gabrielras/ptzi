# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:cpf) }

    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }

    context 'when the cpf is valid' do
      subject(:user) { described_class.new(cpf: '329.726.820-41') }

      it 'doesn`t add invalid cpf error message' do
        user.valid?

        expect(user.errors[:cpf]).to be_empty
      end
    end

    context 'when the cpf is invalid' do
      subject(:user) { described_class.new(cpf: '329.716.820-41') }

      it 'adds invalid cpf error message' do
        user.valid?

        error_message = 'cpf is not a valid number'
        expect(user.errors[:cpf]).to include error_message
      end
    end

    it { is_expected.to allow_value('email@addresse.com').for(:email) }
    it { is_expected.to_not allow_value('info.com').for(:email) }

    subject { User.new(name: 'user') }
    it { should validate_uniqueness_of(:cpf) }
    it { should validate_uniqueness_of(:email) }
  end
end
