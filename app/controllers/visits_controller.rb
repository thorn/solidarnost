class VisitsController < ApplicationController
  def index
    @visits = Visit.all

    respond_to do |format|
      format.html 
      format.json { render json: @visits }
    end
  end

  def show
    @visit = Visit.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @visit }
    end
  end

  def new
    if params[:family_id] && !Family.find_by_id(params[:family_id]).blank?
      @visit = Visit.new(:family_id => params[:family_id])
    else
      redirect_to root_path
    end
  end

  def edit
    @visit = Visit.find(params[:id])
  end

  def create
    @visit = Visit.new(params[:visit])

    respond_to do |format|
      if @visit.save
        format.html { redirect_to family_path(@visit.family), notice: 'Visit was successfully created.' }
        format.json { render json: @visit, status: :created, location: @visit }
      else
        format.html { render action: "new" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update_attributes(params[:visit])
        format.html { redirect_to family_path(@visit.family), notice: 'Visit was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @visit = Visit.find(params[:id])
    @family = @visit.family
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to @family }
      format.json { head :ok }
    end
  end
end
