# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :cpf, presence: true

  validates :email, uniqueness: true
  validates :cpf, uniqueness: true

  validates :name, length: { minimum: 3 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :cpf_number_must_be_valid

  has_many :orders, dependent: :destroy

  private

  def cpf_number_must_be_valid
    errors.add(:cpf, 'cpf is not a valid number') unless CPF.valid?(cpf)
  end
end
