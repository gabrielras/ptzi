# frozen_string_literal: true

class UsersController < ApplicationController
  include UserHelper

  def index
    @users = Pitzi::Users.new.list['list']
  end

  def new; end

  def edit
    @user_id = params[:id]
  end

  def create
    user = Pitzi::Users.new.create(request_params)
    if user['user'].present?
      redirect_to users_path
    else
      redirect_to new_user_path, alert: helpers.response_failed(user).to_s
    end
  end

  def update
    user = Pitzi::Users.new.update(params[:id], request_params)
    if user['user'].present?
      redirect_to users_path, notice: "update #{params[:id]}"
    else
      redirect_to edit_user_path(id: params[:id]), alert: helpers.response_failed(user).to_s
    end
  end

  def destroy
    Pitzi::Users.new.destroy(params[:id])
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:cpf, :email, :name)
  end
end
