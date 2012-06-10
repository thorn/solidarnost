class Admin::HelpTypesController < Admin::BaseController

  before_filter :find_help_type, only: [:edit, :update, :destroy]

  def index
    @help_types = HelpType.all
  end

  def new
    @help_type = HelpType.new
  end

  def edit
  end

  def create
    @help_type = HelpType.new(params[:help_type])

    if @help_type.save
      redirect_to admin_help_types_path, notice: 'Help type was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @help_type.update_attributes(params[:help_type])
      redirect_to admin_help_types_path, notice: 'Help type was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @help_type.destroy
    redirect_to admin_help_types_path
  end

  private
    def find_help_type
      @help_type = HelpType.find(params[:id])
    end
end
