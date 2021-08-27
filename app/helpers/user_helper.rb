# frozen_string_literal: true

module UserHelper
  def request_params
    {
      name: user_params[:name],
      email: user_params[:email],
      cpf: user_params[:cpf]
    }.reject { |_, v| v.blank? }
  end
end
