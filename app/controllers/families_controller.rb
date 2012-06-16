class FamiliesController < ApplicationController
  respond_to :html, :json

  def index
    @q = Family.search(params[:search])
    @families = @q.paginate(:page => params[:page], :per_page => 30)
    @groups = Group.for_families

    respond_to do |format|
      format.html
      format.json { render json: @families }
    end
  end

  def show
    @family = Family.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @family}
    end
  end

  def new
    @family = Family.new
    @family.children.build
    @family.build_mother
    @family.build_father
    @family.build_trusty

    respond_to do |format|
      format.html
      format.json { render json: @family }
    end
  end

  def edit
    @family = Family.find(params[:id])
    @family.children.build
    @family.build_mother if @family.mother.nil?
    @family.build_father if @family.father.nil?
    @family.build_trusty if @family.trusty.nil?
  end

  def create
    @family = Family.new(params[:family])
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i}

    respond_to do |format|
      if @family.save
        format.html { redirect_to families_path, notice: 'Family was successfully created.' }
        format.json { render json: @family, status: :created, location: @family }
      else
        format.html { render action: "new" }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @family = Family.find(params[:id])
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i}

    respond_to do |format|
      if @family.update_attributes(params[:family])
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
        format.json { respond_with_bip(@family) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@family)}
      end
    end
  end

  def destroy
    @family = Family.find(params[:id])
    @family.destroy

    respond_to do |format|
      format.html { redirect_to families_url }
      format.json { head :ok }
    end
  end

end
