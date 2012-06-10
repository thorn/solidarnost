class Admin::UsersController < ApplicationController
  respond_to :html, :json
  before_filter :find_user, :only => [:show, :edit, :update]
  def index
    @users = User.all
    respond_with @users
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :edit
    end
  end

private
  def find_user
    @user = User.find(params[:id])
  end
end
