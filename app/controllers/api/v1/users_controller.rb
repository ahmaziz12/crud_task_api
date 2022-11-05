class Api::V1::UsersController < ApplicationController
 before_action :set_user, except: %i[index create]

  def index
    users = User.all
    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      raise ExceptionHandler::ValidationError.new(@users.errors.to_h, 'Error while creating user.')
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      raise ExceptionHandler::ValidationError.new(@users.errors.to_h, 'Error updating user.')
    end
  end

  def destroy
    if @user.destroy
      render json: User.all
    else
      raise ExceptionHandler::ValidationError.new(@users.errors.to_h, 'Error while deleting user.')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :address)
  end

end
