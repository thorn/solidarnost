class NecessitiesController < ApplicationController

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
      redirect_to necessities_path, notice: 'Necessity was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @necessity.update_attributes(params[:necessity])
      redirect_to necessities_path, notice: 'Necessity was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @necessity.destroy
    redirect_to necessities_url
  end

  private
    def find_necessity
      @necessity = Necessity.find(params[:id])
    end
end
