# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user, factory: :user

    imei { 448_674_528_976_410 }
    annual_price { 1000 }
    device_model { 'Iphone' }
    installments { 4 }
  end
end
