class GroupOption < ActiveRecord::Base
  belongs_to :group
  has_many :families, :dependent => :destroy

  validates :name, :presence => true

  validates :amount_start, :presence => true, :if => :is_source
  validates :amount_end,   :presence => true, :if => :is_source

  scope :health,    where(:group_id => Group.where(:groupName => "health"))
  scope :home,      where(:group_id => Group.where(:groupName => "home"))
  scope :resource,  where(:group_id => Group.where(:groupName => "resource"))
  scope :source,    where(:group_id => Group.where(:groupName => "source"))

  def is_source
    group_id == Group.find_by_groupName("source")
  end
end
