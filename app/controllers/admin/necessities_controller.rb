class Admin::NecessitiesController < Admin::BaseController

  before_filter :find_necessity, only: [:show, :edit, :update, :destroy]

  def index
    @necessities = Necessity.all
  end

  def show
  end

  def new
    @necessity = Necessity.new
  end

  def edit
  end

  def create
    @necessity = Necessity.new(params[:necessity])

    if @necessity.save
      redirect_to admin_necessities_path, notice: 'Necessity was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @necessity.update_attributes(params[:necessity])
      redirect_to admin_necessities_path, notice: 'Necessity was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @necessity.destroy
    redirect_to admin_necessities_path
  end

  private
    def find_necessity
      @necessity = Necessity.find(params[:id])
    end
end
