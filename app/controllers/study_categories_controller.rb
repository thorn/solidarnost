class StudyCategoriesController < ApplicationController

  def index
    @study_categories = StudyCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @study_categories }
    end
  end

  def show
    @study_category = StudyCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @study_category }
    end
  end

  def new
    @study_category = StudyCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @study_category }
    end
  end

  def edit
    @study_category = StudyCategory.find(params[:id])
  end

  def create
    @study_category = StudyCategory.new(params[:study_category])

    respond_to do |format|
      if @study_category.save
        format.html { redirect_to study_categories_path, notice: 'Study category was successfully created.' }
        format.json { render json: @study_category, status: :created, location: @study_category }
      else
        format.html { render action: "new" }
        format.json { render json: @study_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @study_category = StudyCategory.find(params[:id])

    respond_to do |format|
      if @study_category.update_attributes(params[:study_category])
        format.html { redirect_to study_categories_path, notice: 'Study category was successfully updated.' }
        format.json { respond_with_bip(@study_category) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@study_category) }
      end
    end
  end

  def destroy
    @study_category = StudyCategory.find(params[:id])
    @study_category.destroy

    respond_to do |format|
      format.html { redirect_to study_categories_url }
      format.json { head :ok }
    end
  end
end
