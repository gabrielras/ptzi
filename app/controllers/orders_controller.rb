# frozen_string_literal: true

class OrdersController < ApplicationController
  include OrderHelper

  def index
    @orders = Pitzi::Orders.new.list['list']
  end

  def new; end

  def create
    order = Pitzi::Orders.new.create(request_params)
    if order['order'].present?
      redirect_to orders_path
    else
      redirect_to new_order_path, alert: helpers.response_failed(order).to_s
    end
  end

  def destroy
    Pitzi::Orders.new.destroy(params[:id])
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:imei, :annual_price, :device_model, :installments,
                                  :user_id, user: %i[cpf email name])
  end
end
