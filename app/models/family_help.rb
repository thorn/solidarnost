# -*- coding: utf-8 -*-
class FamilyHelp < ActiveRecord::Base
  before_create :create_visit
  belongs_to :family
  belongs_to :visit
  belongs_to :help_type

  has_many :family_help_funds
  has_many :funds, through: :family_help_funds

  has_many :help_users, dependent: :destroy
  has_many :users, through: :help_users

  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids
  end

  attr_reader :fund_tokens

  def fund_tokens=(ids)
    self.fund_ids = ids
  end

  def family_name
    self.family.title if self.family
  end

  def family_priority
    self.family.priority if self.family
  end

  def help_type_name
    self.help_type.name if self.help_type
  end

  def user_names
    self.users.map(&:name).join(' ')
  end

  def fund_names
    self.funds.map(&:name).join(' ')
  end

  def created_date
    self.created_at.to_date if self.created_at
  end

  def family_member_count
    self.family.member_counter
  end

  def family_address
    self.family.address
  end

  def family_phone
    self.family.phone
  end

  scope :during_visits, where("visit_id IS NOT ?", nil)
  scope :without_visit, where("visit_id IS ?", nil)
  attr_accessor :during_visit

private

  def create_visit
    if self.during_visit == "1"
      @visit = Visit.create!(
        description: "Visit with help",
        family_id: self.family_id,
        made_at: Date.today,
        visit_date: Date.today,
        fund_ids: self.fund_ids,
        user_ids: self.user_ids
      )
      self.visit_id = @visit.id
    end
  end
end
