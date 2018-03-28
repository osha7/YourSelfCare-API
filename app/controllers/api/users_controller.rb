class Api::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update]

  def index
    render json: User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user && @user.save
      log_user_in
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
      params.require(:user).permit(
        :name,
        :email,
        medication_ids:[],
        :medications_attributes => [:id, :name, :dose, :prescribed, :first_dose, :notes, :_destroy])
        insurance_ids:[],
        :insurances_attributes => [:id, :name, :address, :phone, :notes, :_destroy])
        provider_ids:[],
        :providers_attributes => [:id, :name, :address, :phone, :first_visit, :notes, :provider_type, :_destroy])
    end

end