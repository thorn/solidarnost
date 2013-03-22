#-*- encoding: utf-8 -*-
class FamiliesController < ApplicationController
  respond_to :html, :json
  before_filter :find_family, only: [:show, :edit, :update, :destroy, :persist]
  before_filter :make_layout, only: [:edit, :new, :show]
  before_filter :gather_news_info, only: [:index, :edit, :new, :show, :search]
  before_filter :find_groups, only: [:index, :search]
  filter_access_to [:show, :edit, :update, :destroy], attribute_check: true

  def index
    go_ids = params[:group_options_id_in].reject { |e| e == "" } if params[:group_options_id_in]

    if go_ids.nil? or go_ids.length.zero?
      @search = Family.order("id DESC").includes(:area).includes(:city).search(params[:search])
    else
      @search = Family.order("id DESC").includes(:area).includes(:city).joins(:group_options).where(group_options: {id: go_ids}).group("families.id").having("count(families.id)= ?", go_ids.length).search(params[:search])
    end
    @families = @search.page(params[:page]).per_page(100)

  end

  def show
    @incomes = @family.incomes.joins(:setting).order('settings.start')
    @expenses = @family.expenses.joins(:setting).order('settings.start')
  end

  def new
    persisted = params[:persisted] == "false" ? Family::NOT_PERSISTED : Family::PERSISTED
    @family = Family.new(status: persisted)
    @family.children.build
    @family.family_members.build
    @family.build_mother
    @family.build_father
    @family.build_trusty
    @income_settings = Setting.incomes.order(:start)
    @income_settings.each do |s|
      @family.incomes.build(setting_id: s.id)
    end
    @expense_settings = Setting.expenses.order(:start)
    @expense_settings.each do |s|
      @family.expenses.build(setting_id: s.id)
    end
  end

  def edit
    @family.children.build
    @family.family_members.build
    @family.build_mother if @family.mother.nil?
    @family.build_father if @family.father.nil?
    @family.build_trusty if @family.trusty.nil?
    @income_settings = Setting.incomes
    @income_settings.each do |s|
      @family.incomes.build(setting_id: s.id) if !@family.incomes.map(&:setting_id).include?(s.id)
    end
    @expense_settings = Setting.expenses
    @expense_settings.each do |s|
      @family.expenses.build(setting_id: s.id) if !@family.expenses.map(&:setting_id).include?(s.id)
    end
  end

  def create
    @family = Family.new(params[:family])
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i} if params[:group_option_ids]
    if @family.save
      @family.process_visits(params[:family])
      News.create_about @family
      redirect_to families_path, notice: 'Family was successfully created.'
    else
      render :new
    end
  end

  def update
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i} if params[:group_option_ids]
    if @family.update_attributes(params[:family])
      @family.process_visits(params[:family])
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
    FamilySearch.search(params)
    @search = Family.order("id DESC").search(params[:search])

    @families = @search.relation.select("DISTINCT(families.id), families.*").order("id DESC").page(params[:page]).per_page(100)
    @whole_families = @search.count
    @whole_people = @search.all.map(&:member_counter).compact.sum
    @whole_children = @search.all.map(&:children_counter).compact.sum
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

  def persist
    @family.persists? ? @family.unpersist! : @family.persist!
    redirect_to family_path(@family)
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

    def find_groups
      @groups = Group.includes(:group_options).for_families.visible
    end
end
