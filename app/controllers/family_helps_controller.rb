class FamilyHelpsController < ApplicationController

  before_filter :find_help, only: [:edit, :update, :destroy, :show]

  def index
    @helps = FamilyHelp.all
  end

  def show
  end

  def new
    if params[:family_id] && !Family.find_by_id(params[:family_id]).blank?
      @help = FamilyHelp.new(:family_id => params[:family_id])
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def create
    @help = FamilyHelp.new(params[:family_help])

    if @help.save
      redirect_to family_path(@help.family), notice: 'FamilyHelp was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @help.update_attributes(params[:family_help])
      redirect_to family_path(@help.family), notice: 'FamilyHelp was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @help.destroy
    redirect_to family_helps_path
  end

  private
    def find_help
      @help = FamilyHelp.find(params[:id])
    end
end
