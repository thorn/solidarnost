require "date"
class FamilySearch
  def self.search(par)
    if par[:search] && par[:search][:city_id_in]
      city = City.find(par[:search][:city_id_in])
      par[:search][:city_id_in] = city.subtree.map(&:id) if city
    end
    obj = Family
    go_ids = par[:group_options_id_in].reject { |e| e == "" } if par[:group_options_id_in]
    if (go_ids.nil? or go_ids.length.zero?)
      object_to_search = Family
    else
      object_to_search = Family.joins(:group_options).where(group_options: {id: go_ids}).group("families.id").having("count(families.id)= ?", go_ids.length).map(&:id)
      par[:search][:id_in] = object_to_search
    end

    if (par[:date_from] != '' or par[:date_to] != '' ) and (par[:help_type])
      help_from = par[:date_from] == '' ? Date.today : Date.parse(par[:date_from])
      help_to   = par[:date_to] == '' ? Date.today : Date.parse(par[:date_to])
      ids_with_help = Family.includes(:family_helps).where("family_helps.made_at >= ? and family_helps.made_at <= ? and family_helps.help_type_id = ?", help_from, help_to, par[:help_type].to_i).map(&:id) << -1
      par[:search][:id_not_in] = ids_with_help
      obj = obj.where("id NOT IN (?)", ids_with_help)
    end

    if par[:with_one_parent]
      @search = obj.order(:id).where("children_counter > ? AND (mother_counter = ? OR father_counter = ?)", 0, 0, 0).search(par[:search])
    elsif par[:without_parents]
      @search = obj.order(:id).where("children_counter > ? AND (mother_counter = ? AND father_counter = ?)", 0, 0, 0).search(par[:search])
    else
      @search = obj.order(:id).search(par[:search])
    end
    @search
  end

end
