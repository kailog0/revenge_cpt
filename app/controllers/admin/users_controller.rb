# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all
    end

    def show
      # nothing
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(paramms[:id])
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}を登録しました。」"
      else
        render new
      end
    end

    def update
      @user = User.find(@arams[:id])

      if @user.update(user_params)
        redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_user_url, notice: "ユーザー[#{@user.name}]を削除しました。"
    end

    private

    def user_params
      params.require(:user).permit(:name, :admin, :password, :pssword_confirmation)
    end
  end
end
