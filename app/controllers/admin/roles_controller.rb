class Admin::RolesController < Admin::BaseController

  before_filter :find_role, only: [:show, :edit, :update, :destroy]

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(params[:role])

    if @role.save
      redirect_to admin_roles_path, notice: 'Role was successfully created.'
    else
      render action: "new"
    end
  end

  def update

    if @role.update_attributes(params[:role])
      redirect_to admin_roles_path, notice: 'Role was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    redirect_to admin_roles_path
  end

  private
    def find_role
      @role = Role.find(params[:id])
    end
end
