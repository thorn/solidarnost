#-*- encoding: utf-8 -*-
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
    @whole_visits = @search.count
    if @visits.length > 0
      @families = Family.where(id: @visits.map(&:family_id).uniq)
      fam = Family.select("member_counter").where(id: @search.all.map(&:family_id).uniq)
      @whole_people = fam.sum(:member_counter)
      @whole_families = fam.count
    else
      @families = []
      @whole_people = 0
      @whole_families = 0
    end
    @groups = Group.for_families.includes(:group_options)
    respond_to do |format|
      format.html
      format.xls do
        render  xls: @families,
                columns: [
                  :id,
                  :title,
                  :full_city_name,
                  :address,
                  :area_name,
                  :phone,
                  :member_counter
                ],
                headers: %w[ ID Название Город Адрес Район Телефон Людей ]
      end
    end
  end

  private

    def find_visit
      @visit = Visit.find(params[:id])
    end
end
