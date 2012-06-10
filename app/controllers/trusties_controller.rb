class TrustiesController < ApplicationController
  # GET /trusties
  # GET /trusties.json
  def index
    @trusties = Trusty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trusties }
    end
  end

  # GET /trusties/1
  # GET /trusties/1.json
  def show
    @trusty = Trusty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trusty }
    end
  end

  # GET /trusties/new
  # GET /trusties/new.json
  def new
    @trusty = Trusty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trusty }
    end
  end

  # GET /trusties/1/edit
  def edit
    @trusty = Trusty.find(params[:id])
  end

  # POST /trusties
  # POST /trusties.json
  def create
    @trusty = Trusty.new(params[:trusty])

    respond_to do |format|
      if @trusty.save
        format.html { redirect_to family_path(@trusty.family), notice: 'Trusty was successfully created.' }
        format.json { render json: @trusty, status: :created, location: @trusty }
      else
        format.html { render action: "new" }
        format.json { render json: @trusty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trusties/1
  # PUT /trusties/1.json
  def update
    @trusty = Trusty.find(params[:id])

    respond_to do |format|
      if @trusty.update_attributes(params[:trusty])
        format.html { redirect_to redirect_to family_path(@trusty.family), notice: 'Trusty was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @trusty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trusties/1
  # DELETE /trusties/1.json
  def destroy
    @trusty = Trusty.find(params[:id])
    @fam = @trusty.destroy.family

    respond_to do |format|
      format.html { redirect_to family_path(@fam) }
      format.json { head :ok }
    end
  end
end
