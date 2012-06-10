class FamilyHelpsController < ApplicationController
  def index
    @helps = FamilyHelp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @helps }
    end
  end

  def show
    @help = FamilyHelp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @help }
    end
  end

  def new
    if params[:family_id] && !Family.find_by_id(params[:family_id]).blank?
      @help = FamilyHelp.new(:family_id => params[:family_id])
    else
      redirect_to root_path
    end
  end

  def edit
    @help = FamilyHelp.find(params[:id])
  end

  def create
    @help = FamilyHelp.new(params[:family_help])

    respond_to do |format|
      if @help.save
        format.html { redirect_to family_path(@help.family), notice: 'FamilyHelp was successfully created.' }
        format.json { render json: @help, status: :created, location: @help }
      else
        format.html { render action: "new" }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @help = FamilyHelp.find(params[:id])

    respond_to do |format|
      if @help.update_attributes(params[:family_help])
        format.html { redirect_to family_path(@help.family), notice: 'FamilyHelp was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @help = FamilyHelp.find(params[:id])
    @help.destroy

    respond_to do |format|
      format.html { redirect_to family_helps_path }
      format.json { head :ok }
    end
  end
end
