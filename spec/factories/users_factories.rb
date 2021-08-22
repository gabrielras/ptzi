# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'User Test' }
    email { 'test@test.com' }
    cpf { '329.726.820-41' }
  end
end
