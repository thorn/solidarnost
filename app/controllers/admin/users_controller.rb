class Admin::UsersController < Admin::BaseController
  respond_to :html, :json
  before_filter :find_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.scoped
    respond_with @users
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

private
  def find_user
    @user = User.find(params[:id])
  end
end
