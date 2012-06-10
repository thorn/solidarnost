class Admin::CitiesController < Admin::BaseController

  def index
    @cities = City.all
  end

  def show
  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(params[:city])

    if @city.save
      redirect_to admin_cities_path, notice: 'City was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @city.update_attributes(params[:city])
      redirect_to admin_cities_path, notice: 'City was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @city.destroy
    redirect_to admin_cities_path
  end

  private
    def find_city
      @city = City.find(params[:id])
    end
end
