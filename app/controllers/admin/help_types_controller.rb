class HelpTypesController < ApplicationController

  def index
    @help_types = HelpType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @help_types }
    end
  end

  def show
    @help_type = HelpType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @help_type }
    end
  end

  def new
    @help_type = HelpType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @help_type }
    end
  end

  def edit
    @help_type = HelpType.find(params[:id])
  end

  def create
    @help_type = HelpType.new(params[:help_type])

    respond_to do |format|
      if @help_type.save
        format.html { redirect_to help_types_path, notice: 'Help type was successfully created.' }
        format.json { render json: @help_type, status: :created, location: @help_type }
      else
        format.html { render action: "new" }
        format.json { render json: @help_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @help_type = HelpType.find(params[:id])

    respond_to do |format|
      if @help_type.update_attributes(params[:help_type])
        format.html { redirect_to help_types_path, notice: 'Help type was successfully updated.' }
        format.json { respond_with_bip(@help_type) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@help_type) }
      end
    end
  end

  def destroy
    @help_type = HelpType.find(params[:id])
    @help_type.destroy

    respond_to do |format|
      format.html { redirect_to help_types_url }
      format.json { head :ok }
    end
  end
end
