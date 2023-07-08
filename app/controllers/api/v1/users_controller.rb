class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.json { render json: @users, status: 200 }
    end
  end

  def show
    if params[:id] == 'sign_out'
      sign_out current_user
      redirect_to new_user_session_path, notice: 'Sign out succesfully' unless @user
      format.json { render status: 200 }
    else
      @user = User.find_by(id: params[:id])
      respond_to do |format|
        redirect_to users_path, notice: 'User found' unless @user
        format.json { render json: @user, status: 200 }
      end
    end
  end
end
