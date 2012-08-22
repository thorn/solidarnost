class VisitsController < ApplicationController
  before_filter :find_visit, only: [:show, :update, :edit, :destroy]

  def index
    @visits = Visit.all
  end

  def show
  end

  def new
    if params[:family_id] && !Family.find_by_id(params[:family_id]).blank?
      @visit = Visit.new(family_id: params[:family_id])
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def create
    @visit = Visit.new(params[:visit])

    if @visit.save
      News.create_about @visit
      redirect_to family_path(@visit.family), notice: 'Visit was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @visit.update_attributes(params[:visit])
      redirect_to family_path(@visit.family), notice: 'Visit was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @family = @visit.family
    @visit.destroy
    redirect_to @family
  end

  def search
    @search = Visit.search(params[:search])
    @visits = @search.page(params[:page]).per_page(100)
    @whole_visits = @search.all.length
    if @visits.length > 0
      @families = Family.where(id: @visits.map(&:family_id))
      @whole_people = @families.sum(:member_counter)
      @whole_families = @families.count
    else
      @families = []
      @whole_people = 0
      @whole_families = 0
    end
    @groups = Group.for_families
  end

  private

    def find_visit
      @visit = Visit.find(params[:id])
    end
end
