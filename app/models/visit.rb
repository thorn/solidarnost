class Visit < ActiveRecord::Base

  belongs_to :family

  has_many :visit_funds
  has_many :funds, through: :visit_funds

  has_one :family_help

  has_many :assistances
  has_many :users, :through => :assistances

  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids
  end

  attr_reader :fund_tokens

  def fund_tokens=(ids)
    self.fund_ids = ids
  end
  scope :without_help, lambda{
    joins("LEFT JOIN family_helps ON family_helps.visit_id=visits.id")
    .where('family_helps.visit_id is ?', nil)
  }
  scope :with_help, lambda{
    joins(:family_help).
    where("family_helps.visit_id IS NOT ?", nil)
  }
end
