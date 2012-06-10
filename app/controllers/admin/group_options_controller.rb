class Admin::GroupOptionsController < Admin::BaseController

  before_filter :find_group_option, only: [:show, :edit, :update, :destroy]

  def index
    @group_options = GroupOption.all
  end

  def show
  end

  def new
    @group_option = GroupOption.new
  end

  def edit
  end

  def create
    @group_option = GroupOption.new(params[:group_option])

    if @group_option.save
      redirect_to admin_group_options_path, notice: 'Group option was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @group_option.update_attributes(params[:group_option])
      redirect_to admin_group_options_path, notice: 'Group option was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @group_option.destroy
    redirect_to admin_group_options_path
  end

  private
    def find_group_option
      @group_option = GroupOption.find(params[:id])
    end
end
