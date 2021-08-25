# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Update, type: :action do
  describe 'Inputs' do
    subject { described_class.inputs }

    it { is_expected.to include(id: { type: String }) }
    it { is_expected.to include(attributes: { type: Hash }) }
  end

  describe 'Outputs' do
    subject { described_class.outputs }

    it { is_expected.to include(user: { type: User }) }
  end

  describe '#call' do
    subject(:result) { described_class.result(id: user_id, attributes: attributes) }

    context 'when user doesn`t exist' do
      let(:user_id) { 'error' }
      let(:attributes) { {} }

      it { expect { result }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'when attributes are valid' do
      let(:user) { create(:user) }
      let(:user_id) { user.id.to_s }
      let(:attributes) { { name: 'Test Name' } }

      it { is_expected.to be_success }

      it 'updates user with given attribute' do
        result

        expect(user.reload.attributes).to include(attributes.stringify_keys)
      end
    end

    context 'when attributes are invalid' do
      let(:user) { create(:user) }
      let(:user_id) { user.id.to_s }
      let(:attributes) { { cpf: '123-123-123-12' } }

      it { expect { result }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
