class Order < ApplicationRecord
  belongs_to :user
  
  validates :imei, presence: true
  validates :annual_price, presence: true
  validates :device_model, presence: true
  validates :installments, presence: true
  validates :user_id, presence: true

  validates :imei, uniqueness: true

  validates :annual_price, numericality: { greater_than: 0 }
  validates :installments, numericality: { greater_than: 0, less_than: 13 }
  validates :imei, numericality: { greater_than: 0 }

  validate :imei_must_be_a_valid_number

  private

  def imei_must_be_a_valid_number
    unless ImeiValidator.new(imei).result
      errors.add(:imei, 'imei is not a valid number')
    end
  end
end
