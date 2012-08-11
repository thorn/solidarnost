#-*- encoding: utf-8 -*-
class Admin::CitiesController < Admin::BaseController

before_filter :find_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = City.scoped.order(:id).page(params[:page]).per_page(100)
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

  def get_new
    city = City.find_by_id(params[:id])
    children = city.children.order(:name).map{|c| {name: c.name, id: c.id}}
    last = children.length.zero? ? true: false
    response = {cities: children, last: last}

    respond_to do |format|
      if city
        format.json {render json: response.to_json}
      else
        format.json {render json: {error: "Нет такого горда"}}
      end
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
