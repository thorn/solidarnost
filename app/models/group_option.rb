class GroupOption < ActiveRecord::Base
  belongs_to :group
  has_many :coefficients
  has_many :families, through: :coefficients,source: :coefficientable, :source_type => 'Family'

  validates :name, presence: true

  validates :amount_start, presence: true, if: :is_source
  validates :amount_end,   presence: true, if: :is_source

  scope :health,    where(group_id: Group.where(name: "health"))
  scope :home,      where(group_id: Group.where(name: "home"))
  scope :resource,  where(group_id: Group.where(name: "resource"))
  scope :source,    where(group_id: Group.where(name: "source"))

  def is_source
    group_id == Group.find_by_name("source")
  end
end
