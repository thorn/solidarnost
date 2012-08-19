class PagesController < ApplicationController
  respond_to :html
  def home
  end

  def about
  end

  def delete_multiple
    puts params[:model]
    puts params[:ids]
    case params[:model]
      when "Families"
        Family.find_all_by_id(params[:model_ids]).each do |family|
          family.destroy
        end
        redirect_to families_path
      when "Groups"
        Group.find_all_by_id(params[:model_ids]).each do |group|
          group.destroy
        end
        redirect_to admin_groups_path
      when "Group_options"
        GroupOption.find_all_by_id(params[:model_ids]).each do |group_option|
          group_option.destroy
        end
        redirect_to admin_group_options_path
      when "Cities"
        City.find_all_by_id(params[:model_ids]).each do |city|
          city.destroy
        end
        redirect_to admin_cities_path
      when "Help_types"
        HelpType.find_all_by_id(params[:model_ids]).each do |help_type|
          help_type.destroy
        end
        redirect_to admin_help_types_path
      when "Necessities"
        Necessity.find_all_by_id(params[:model_ids]).each do |nec|
          nec.destroy
        end
        redirect_to admin_necessities_path
      when "StudyCategories"
        StudyCategory.find_all_by_id(params[:model_ids]).each do |study_category|
          study_category.destroy
        end
        redirect_to admin_study_categories_path
      when "Users"
        User.find_all_by_id(params[:model_ids]).each do |user|
          user.destroy
        end
        redirect_to admin_users_path
      when "Roles"
        Role.find_all_by_id(params[:model_ids]).each do |role|
          role.destroy
        end
        redirect_to admin_roles_path
      when "Settings"
        Setting.find_all_by_id(params[:model_ids]).each do |setting|
          setting.destroy
        end
        redirect_to admin_settings_path
      when "Funds"
        Fund.find_all_by_id(params[:model_ids]).each do |fund|
          fund.destroy
        end
        redirect_to admin_funds_path
      when "FamilyHelps"
        FamilyHelp.find_all_by_id(params[:model_ids]).each do |help|
          help.destroy
        end
        redirect_to search_family_helps_path
      when "Visits"
        Visit.find_all_by_id(params[:model_ids]).each do |visit|
          visit.destroy
        end
        redirect_to search_visits_path
      when "Areas"
        Area.find_all_by_id(params[:model_ids]).each do |area|
          area.destroy
        end
        redirect_to admin_areas_path
      else
        redirect_to families_path
    end
  end

  def read_multiple
    case params[:model]
      when "News"
        News.find_all_by_id(params[:model_ids]).each do |news|
          news.read!
        end
        redirect_to admin_news_index_path
    end
  end

end
