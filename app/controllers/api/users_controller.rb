class Api::UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:create]
  # before_action :set_user, only: [:show, :update]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user && @user.save
      render json: @user
    else
      render json: { message: @user.errors }, status: 400
    end
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { message: @user.errors }, status: 400
    end
  end

  def destroy
    @user.destroy
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
