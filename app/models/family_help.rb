# -*- coding: utf-8 -*-
class FamilyHelp < ActiveRecord::Base
  after_create :create_visit
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

  scope :during_visits, where("visit_id IS NOT ?", nil)
  scope :without_visit, where("visit_id IS ?", nil)
  attr_accessor :during_visit

private

  def create_visit
    if self.during_visit == "1"
      @visit = Visit.create!(description: "Visit with help", family_id: self.family_id)
      self.update_attribute(:visit_id, @visit.id)
    end
  end
end
