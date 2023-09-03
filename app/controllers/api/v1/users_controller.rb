class Api::V1::UsersController < ApplicationController
  
  before_action :set_user, only: %i[show update destroy]

  # GET /api/v1/users
  def index
    @users = User.all
    # render json: @users Este es el original
    render json: @users.to_json(only: %i[id username]) # De esta forma podemos devolver los campos deseados
  end

  # GET /api/v1/users/1
  def show
    # render json: @user Este es el original
    render json: @user.to_json(only: %i[id username]) # De esta forma podemos devolver los campos deseados
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end

end
