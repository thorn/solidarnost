require "date"
class FamilySearch
  def self.search(par)
    par[:search] = par[:search] || {}
    if par[:search][:city_id_in]
      city = City.find(par[:search][:city_id_in])
      par[:search][:city_id_in] = city.subtree.map(&:id) if city
    end

    unless par[:fund_id].blank?
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

    if (par[:help_type]) and (!par[:date_from].blank? or !par[:date_to].blank? )
      help_from = par[:date_from].blank? ? Date.today : Date.parse(par[:date_from])
      help_to   = par[:date_to].blank? ? Date.today : Date.parse(par[:date_to])
      help_type = par[:help_type].blank? ? HelpType.all.map(&:id) : par[:help_type].to_i
      if par[:help_fund_ids] && par[:help_fund_ids].length > 0
        no_help_from_fund_ids = par[:help_fund_ids].map(&:to_i)
      end
      family_helps = FamilyHelp.includes(:family_help_funds).where(
        "    made_at >= ?
         and made_at <= ?
        ",
        help_from,
        help_to
      ).where(help_type_id: help_type, "family_help_funds.fund_id" => no_help_from_fund_ids)
      ids_with_help = family_helps.map(&:family_id)
      par[:search][:id_not_in] = ids_with_help
      # ids_with_help = Family.includes(:family_helps)
      # .where(
      #      "family_helps.made_at >= ?
      #   and family_helps.made_at <= ?
      #   and family_helps.help_type_id = ?",
      #   help_from,
      #   help_to,
      #   par[:help_type].to_i
      # ).map(&:id) << -1
      # par[:search][:id_not_in] = ids_with_help
    end

    if par[:without_mother]
      par[:search][:mother_counter_equals] = 0
      par[:search][:children_counter_greater_than] = 0
    end
    if par[:without_father]
      par[:search][:father_counter_equals] = 0
      par[:search][:children_counter_greater_than] = 0
    end
    if par[:with_mother]
      par[:search][:mother_counter_equals] = 1
    end
    if par[:with_father]
      par[:search][:father_counter_equals] = 1
    end
  end

end
