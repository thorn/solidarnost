#-*- encoding: utf-8 -*-
class FamiliesController < ApplicationController
  respond_to :html, :json
  before_filter :find_family, only: [:show, :edit, :update, :destroy]
  before_filter :make_layout, only: [:edit, :new, :show]

  def index
    @q = Family.search(params[:search])
    @families = @q.paginate(:page => params[:page], :per_page => 30)
    @groups = Group.for_families
  end

  def show
  end

  def new
    @family = Family.new
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
    @family.group_option_ids = params[:group_option_ids].collect{|id| id.to_i}
    if @family.update_attributes(params[:family])
      redirect_to @family, notice: 'Family was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @family.destroy
    redirect_to families_url
  end

  private

    def find_family
      @family = Family.find(params[:id])
    end

    def make_layout
      @layout = Setting.layout
      @row_count = @layout.select('DISTINCT(name)').count
    end

end
