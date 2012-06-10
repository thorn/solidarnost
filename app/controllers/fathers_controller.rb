class FathersController < ApplicationController
  def index
    @fathers = Father.all

    respond_to do |format|
      format.html
      format.json { render json: @fathers }
    end
  end

  def show
    @father = Father.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @father }
    end
  end

  def new
    @father = Father.new

    respond_to do |format|
      format.html
      format.json { render json: @father }
    end
  end

  def edit
    @father = Father.find(params[:id])
  end

  def create
    @father = Father.new(params[:father])

    respond_to do |format|
      if @father.save
        format.html { redirect_to family_path(@father.family), notice: 'Father was successfully created.' }
        format.json { render json: @father, status: :created, location: @father }
      else
        format.html { render action: "new" }
        format.json { render json: @father.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @father = Father.find(params[:id])

    respond_to do |format|
      if @father.update_attributes(params[:father])
        format.html { redirect_to family_path(@father.family), notice: 'Father was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @father.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @father = Father.find(params[:id])
    @fam = @father.destroy.family

    respond_to do |format|
      format.html { redirect_to family_path(@fam) }
      format.json { head :ok }
    end
  end
end
