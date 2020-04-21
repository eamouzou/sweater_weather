class Api::V1::UsersController < ApplicationController

  def create
    user = create_user
    save_user(user)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def create_user
    User.create(
      email: user_params[:email],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
      api_key: SecureRandom.base64(12)
    )
  end

  def save_user(user)
    render json: UserSerializer.new(user), status: 201 if user.save
    render json: { failed: user.errors.full_messages.to_sentence }, status: 400 if !user.save
  end

end
