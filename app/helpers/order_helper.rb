# frozen_string_literal: true

module OrderHelper
  def request_params
    {
      imei: order_params[:imei],
      annual_price: order_params[:annual_price],
      device_model: order_params[:device_model],
      installments: order_params[:installments],
      user_id: params[:user_id],
      user: {
        name: order_params[:user][:name],
        email: order_params[:user][:email],
        cpf: order_params[:user][:cpf]
      }.reject { |_, v| v.blank? }
    }.reject { |_, v| v.blank? }
  end
end
