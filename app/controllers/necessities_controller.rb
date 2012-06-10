class NecessitiesController < ApplicationController

  def index
    @necessities = Necessity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @necessities }
    end
  end

  def show
    @necessity = Necessity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @necessity }
    end
  end

  def new
    @necessity = Necessity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @necessity }
    end
  end

  def edit
    @necessity = Necessity.find(params[:id])
  end

  def create
    @necessity = Necessity.new(params[:necessity])

    respond_to do |format|
      if @necessity.save
        format.html { redirect_to necessities_path, notice: 'Necessity was successfully created.' }
        format.json { render json: @necessity, status: :created, location: @necessity }
      else
        format.html { render action: "new" }
        format.json { render json: @necessity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @necessity = Necessity.find(params[:id])

    respond_to do |format|
      if @necessity.update_attributes(params[:necessity])
        format.html { redirect_to necessities_path, notice: 'Necessity was successfully updated.' }
        format.json { respond_with_bip(@necessity) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@necessity) }
      end
    end
  end

  def destroy
    @necessity = Necessity.find(params[:id])
    @necessity.destroy

    respond_to do |format|
      format.html { redirect_to necessities_url }
      format.json { head :ok }
    end
  end
end
