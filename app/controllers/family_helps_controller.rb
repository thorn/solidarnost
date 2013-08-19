#-*- encoding: utf-8 -*-
class FamilyHelpsController < ApplicationController

  before_filter :find_help, only: [:edit, :update, :destroy, :show]

  def index
    @helps = FamilyHelp.all
  end

  def show
  end

  def new
    if params[:family_id] && !Family.find_by_id(params[:family_id]).blank?
      @help = FamilyHelp.new(:family_id => params[:family_id])
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def help_search
    @search = FamilyHelp.includes(:family).includes(:help_type).search(params[:search])
    @family_helps = @search.page(params[:page]).per_page(100)
    @whole_amount = @search.all.inject(0){|sum, help| sum += help.amount || 0}
    @whole_help_count = @search.count
    @groups = Group.for_families
    if @family_helps.length > 0
      fam = Family.select("member_counter").where(id: @search.all.map(&:family_id).uniq)
      @whole_people = fam.sum(:member_counter)
      @whole_families = fam.count
    else
      fam = Family.select("member_counter").where(id: @search.all.map(&:family_id).uniq)
      @whole_people = fam.sum(:member_counter)
      @whole_families = fam.count
    end
    respond_to do |format|
      format.html
      format.xls do
        f_h = @search.all
        render  xls: f_h,
                columns: [
                  :family_id,
                  :family_name,
                  :family_priority,
                  :created_date,
                  :amount,
                  :help_type_name,
                  :user_names,
                  :fund_names
                ],
                headers: %W[ ID Имя Приоритет Дата #{"Размер помощи"} Тип Волонтеры Фонд]
      end
    end
  end

  def search
    @search = FamilyHelp.search(params[:search])
    @family_helps = @search.page(params[:page]).per_page(100)
    @whole_amount = @search.all.inject(0){|sum, help| sum += help.amount || 0}
    @groups = Group.for_families
    if @family_helps.length > 0
      @families = Family.where(id: @family_helps.map(&:family_id).uniq)
      fam = Family.select("member_counter").where(id: @search.all.map(&:family_id).uniq)
      @whole_people = fam.sum(:member_counter)
      @whole_families = fam.count
    else
      @families = []
      @whole_people = 0
      @whole_families = 0
    end
    respond_to do |format|
      format.html
      format.xls do
        fam = Family.where(id: @search.all.map(&:family_id).uniq)
        render  xls: fam,
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

  def create
    @help = FamilyHelp.new(params[:family_help])

    if @help.save
      News.create_about @help
      redirect_to family_path(@help.family), notice: 'FamilyHelp was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @help.update_attributes(params[:family_help])
      redirect_to family_path(@help.family), notice: 'FamilyHelp was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    family = @help.destroy.family
    redirect_to family_path(family)
  end

  private
    def find_help
      @help = FamilyHelp.find(params[:id])
    end
end
