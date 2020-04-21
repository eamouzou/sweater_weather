class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params['email'])
    render_and_authenticate(user)
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def render_and_authenticate(user)
    render_success(user) if  user && user.authenticate(user_params[:password])
    render json: { failed: 'Unsuccessful, bad credentials.'}, status: 400 if !user || !user.authenticate(user_params[:password])
  end

  def render_success(user)
    session[:user_id] = user.id
    render json: UserSerializer.new(user), status: 200
  end

end
