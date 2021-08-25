# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Destroy, type: :action do
  describe 'Inputs' do
    subject { described_class.inputs }

    it { is_expected.to include(id: { type: String }) }
  end

  describe 'Outputs' do
    subject { described_class.outputs }

    it { is_expected.to be_empty }
  end

  describe '#call' do
    subject(:result) { described_class.result(id: user_id) }

    context 'when user doesn`t exist' do
      let(:user_id) { 'error' }

      it { expect { result }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'when user exists' do
      let(:user) { create(:user) }
      let(:user_id) { user.id.to_s }

      it { is_expected.to be_success }

      it 'destroys user' do
        result

        expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
