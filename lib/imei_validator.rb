# frozen_string_literal: true

class ImeiValidator
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def result
    sum = 0
    (0..14).each do |i|
      sum += digit_calculation(number.to_s[i].to_i, (i + 1).even?)
    end

    return true if (sum % 10).zero?

    false
  end

  private

  def digit_calculation(value_without_digit, index_key)
    if index_key
      number = value_without_digit * 2
      number = number.to_s[0].to_i + number.to_s[1].to_i while number > 9
      number
    else
      value_without_digit
    end
  end
end
