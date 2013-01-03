class HelpType < Dictionary
  has_many :family_helps, dependent: :destroy
  has_many :families, through: :family_helps
  def collection_for_select
    HelpType.all.collect{|h| [h.id, h.name]}
  end

  def family_info
    {
      families_count: families.uniq.count,
      people_count: families.uniq.map(&:member_counter).sum
    }
  end
end
