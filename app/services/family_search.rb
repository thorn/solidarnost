require "date"
class FamilySearch
  def self.search(par)
    if par[:search]
      if par[:search][:city_id_in]
        city = City.find(par[:search][:city_id_in])
        par[:search][:city_id_in] = city.subtree.map(&:id) if city
      end

      if par[:fund_id] != ''
        user_ids = Fund.find(par[:fund_id]).users.map(&:id)
        par[:search][:users_id_in] = user_ids
      end

      go_ids = par[:group_options_id_in].reject { |e| e == "" } if par[:group_options_id_in]
      if (go_ids.nil? or go_ids.length.zero?)
        object_to_search = Family
      else
        object_to_search = Family.joins(:group_options).where(group_options: {id: go_ids}).group("families.id").having("count(families.id)= ?", go_ids.length).map(&:id)
        par[:search][:id_in] = object_to_search
      end

      if (par[:help_type]) and (par[:date_from] != '' or par[:date_to] != '' )
        help_from = par[:date_from] == '' ? Date.today : Date.parse(par[:date_from])
        help_to   = par[:date_to] == '' ? Date.today : Date.parse(par[:date_to])
        ids_with_help = Family.includes(:family_helps).where("family_helps.made_at >= ? and family_helps.made_at <= ? and family_helps.help_type_id = ?", help_from, help_to, par[:help_type].to_i).map(&:id) << -1
        par[:search][:id_not_in] = ids_with_help
      end

      if par[:search][:without_parents]
        par[:search][:mother_counter_and_father_counter_equals] = 0
        par[:search][:children_counter_greater_than] = 0
      else
        if par[:search][:without_mother]
          par[:search][:children_counter_greater_than] = 0
          par[:search][:mother_counter] = 0
        end
        if par[:search][:without_father]
          par[:search][:children_counter_greater_than] = 0
          par[:search][:father_counter] = 0
        end
      end
    end
  end

end
