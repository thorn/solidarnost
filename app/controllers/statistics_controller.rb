class StatisticsController < ApplicationController
  def index
    @info = gather_info
  end

  def show
    case params[:q]
      when 'families_count'
        redirect_to families_path
      when 'volunteers_count'
        redirect_to admin_users_path
      when 'family_home_need'
        @search = Family.search({:home_id_equals => 20})
      when 'family_resources_need'
        @search = Family.search({:resource_id_equals => 24})
      when 'family_cure_need'
        @search = Family.search()
      when 'family_source_need'
        @search = Family.search({:source_id_equals => 24 })
      when 'children_without_one_parent'
        @families = Family.with_children.with_one_parent
      when 'children_without_two_parents'
        @families = Family.with_children.without_mother.without_father
      when 'children_without_mother'
        @families = Family.with_children.without_mother
      when 'children_without_father'
        @families = Family.with_children.without_father
      else
        @families = Family.all
    end
    if @search
      @families = @search.all 
      render 'pages/search'
    end
  end
private

  def gather_info
    @u = User.all
    @info = {
      'families_count' => Family.count,
      'volunteers_count' => @u.count,
      'help_amount' => FamilyHelp.sum(:amount),
      'visits_made' => Visit.count,
      'family_home_need' => Family.search({:home_id_equals => 20}).count,
      'family_resources_need' => Family.search({:resource_id_equals => 16}).count,
      'family_cure_need' => 0,
      'family_source_need' => Family.search({:source_id_equals => 24 }).count,
      'children_without_one_parent' => Family.with_one_parent.count,
      'children_without_two_parents' => Family.with_children.without_mother.without_father.count,
      'children_without_mother' => Family.with_children.without_mother.count,
      'children_without_father' => Family.with_children.without_father.count
    }
  end
end
