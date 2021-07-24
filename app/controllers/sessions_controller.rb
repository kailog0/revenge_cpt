# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :login_required
  def new; end

  def create
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'ログインしました。'
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
