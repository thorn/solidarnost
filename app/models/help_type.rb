class HelpType < ActiveRecord::Base
  has_many :family_helps, :dependent => :destroy
  def collection_for_select
    HelpType.all.collect{|h| [h.id, h.name]}
  end
end
