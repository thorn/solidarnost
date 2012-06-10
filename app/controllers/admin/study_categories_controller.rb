class Admin::StudyCategoriesController < Admin::BaseController
  before_filter :find_category, only: [:show, :edit, :update, :destroy]
  def index
    @study_categories = StudyCategory.all
  end

  def show
  end

  def new
    @study_category = StudyCategory.new
  end

  def edit
  end

  def create
    @study_category = StudyCategory.new(params[:study_category])

    if @study_category.save
      redirect_to study_categories_path, notice: 'Study category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @study_category.update_attributes(params[:study_category])
      redirect_to study_categories_path, notice: 'Study category was successfully updated.'
    else
      render action: "edit"
    end

  end

  def destroy
    @study_category = StudyCategory.find(params[:id])
    @study_category.destroy

    redirect_to study_categories_url
  end

  private
    def find_category
      @study_category = StudyCategory.find(params[:id])
    end
end
