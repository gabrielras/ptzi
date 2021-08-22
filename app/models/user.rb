class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :cpf, presence: true

  validates :email, uniqueness: true
  validates :cpf, uniqueness: true

  validates :name, length: { minimum: 3 }

  validate :cpf_number_must_be_valid

  private
  
  def cpf_number_must_be_valid
    unless CPF.valid?(cpf)
      errors.add(:cpf, 'cpf is not a valid number')
    end
  end
end
