class Admin::AreasController < Admin::BaseController
before_filter :find_area, only: [:show, :edit, :update, :destroy]

  def index
    @areas = Area.scoped.page(params[:page]).per_page(100)
  end

  def show
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new(params[:area])

    if @area.save
      redirect_to admin_areas_path, notice: 'area was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @area.update_attributes(params[:area])
      redirect_to admin_areas_path, notice: 'area was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @area.destroy
    redirect_to :back
  end

  private
    def find_area
      @area = Area.find(params[:id])
    end
end
