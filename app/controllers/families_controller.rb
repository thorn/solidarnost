#-*- encoding: utf-8 -*-
class FamiliesController < ApplicationController
  respond_to :html, :json
  before_filter :find_family, only: [:show, :edit, :update, :destroy]
  before_filter :make_layout, only: [:edit, :new, :show]
  before_filter :gather_news_info, only: [:index, :edit, :new, :show, :search]
  filter_access_to [:show, :edit, :update, :destroy], attribute_check: true
  def index
    go_ids = params[:group_options_id_in].reject { |e| e == "" } if params[:group_options_id_in]
    object_to_search = (go_ids.nil? or go_ids.length.zero?) ? Family : Family.joins(:group_options).where(group_options: {id: go_ids}).group("families.id").having("count(families.id)= ?", go_ids.length)

    @search = object_to_search.order(:id).search(params[:search])
    @families = @search.page(params[:page]).per_page(100)
    @groups = Group.for_families
  end

  def show
  end

  def new
    @family = Family.new(status: Family::PERSISTED)
    @family.children.build
    @family.build_mother
    @family.build_father
    @family.build_trusty
  end

  def edit
    @family.children.build
    @family.build_mother if @family.mother.nil?
    @family.build_father if @family.father.nil?
    @family.build_trusty if @family.trusty.nil?
  end

  def create
    @family = Family.new(params[:family])
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i} if params[:group_option_ids]
    if @family.save
      News.create_about @family
      @family.visits.create(title: "Мониторинг семьи", visit_date: Date.today, made_at: Date.today)
      redirect_to families_path, notice: 'Family was successfully created.'
    else
      render :new
    end
  end

  def update
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i} if params[:group_option_ids]
    if @family.update_attributes(params[:family].merge(status: Family::PERSISTED))
      redirect_to @family, notice: 'Family was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @family.destroy
    redirect_to families_url
  end

  def search
    if params[:search] && params[:search][:city_id_in]
      city = City.find(params[:search][:city_id_in])
      params[:search][:city_id_in] = city.subtree.map(&:id) if city
    end
    go_ids = params[:group_options_id_in].reject { |e| e == "" } if params[:group_options_id_in]
    object_to_search = (go_ids.nil? or go_ids.length.zero?) ? Family : Family.joins(:group_options).where(group_options: {id: go_ids}).group("families.id").having("count(families.id)= ?", go_ids.length)
    if params[:with_one_parent]
      @search = object_to_search.order(:id).where("children_counter > ? AND (mother_counter = ? OR father_counter = ?)", 0, 0, 0).search(params[:search])
    elsif params[:without_parents]
      @search = object_to_search.order(:id).where("children_counter > ? AND (mother_counter = ? AND father_counter = ?)", 0, 0, 0).search(params[:search])
    else
      @search = object_to_search.order(:id).search(params[:search])
    end

    @families  = @search.page(params[:page]).per_page(100)
    @whole_families = @search.all.length
    @whole_people = @search.all.map(&:member_counter).compact.sum
    @groups = Group.for_families
  end

  private

    def find_family
      @family = Family.find(params[:id])
    end

    def make_layout
      @layout = Setting.layout
      @row_count = @layout.select('DISTINCT(name)').count
    end

    def gather_news_info
      @info = News.get_info
    end

end
