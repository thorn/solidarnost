# -*- encoding: utf-8 -*-
class ChildrenController < ApplicationController
  before_filter :find_child, only: [:destroy, :show]

  def show
  end


  def destroy
    @family = @child.destroy.family
    redirect_to family_path(@family)
  end

  def search
    @search = Child.order("id DESC").search(params[:search])
    @children = @search.page(params[:page]).per_page(100)
    @whole_children = @search.all.length
    if @children.length > 0
      @families = Family.where(id: @search.all.map(&:family_id).uniq)
      @whole_people = @families.sum(:member_counter)
      @whole_families = @families.count
    else
      @families = []
      @whole_people = 0
      @whole_families = 0
    end
    @groups = Group.for_families.includes(:group_options)
    respond_to do |format|
      format.html
      format.xls do
        render  xls: @search.all,
                columns: [
                  :id,
                  :first_name,
                  :second_name,
                  :last_name,
                ],
                headers: %w[ ID Имя Фамлия Отчество ]
      end
    end
  end

  def find_child
    @child = Child.find(params[:id])
  end

end
