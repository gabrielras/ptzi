# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create, type: :action do
  describe 'Inputs' do
    subject { described_class.inputs }

    it { is_expected.to include(attributes: { type: Hash }) }
  end

  describe 'Outputs' do
    subject { described_class.outputs }

    it { is_expected.to include(user: { type: User }) }
  end

  describe '#call' do
    subject(:result) { described_class.result(attributes: attributes) }

    context 'when attributes are valid' do
      let(:attributes) do
        {
          name: 'Name',
          cpf: '329.726.820-41',
          email: 'tes@tes.com'
        }
      end

      it { is_expected.to be_success }

      it 'creates user' do
        expect { result }.to change(User.all, :count).by(1)
      end

      it 'creates user with given attribute' do
        expect(result.user.attributes).to include(attributes.stringify_keys)
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { cpf: '123-123-123-12' } }

      it { expect { result }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
