# -*- encoding: utf-8 -*-
require "date"
class Child < ActiveRecord::Base
  belongs_to :family, counter_cache: :member_counter

  belongs_to :health,   class_name: "GroupOption"
  belongs_to :study, class_name: "StudyCategory", foreign_key: "study_id"
  has_many :coefficients, as: :coefficientable
  has_many :group_options, through: :coefficients
  before_save :set_age

  before_create :increment_counter
  before_destroy :decrement_counter

  def increment_counter
    family.update_attribute(:children_counter, family.children_counter.to_i + 1)
  end

  def decrement_counter
    family.update_attribute(:children_counter, family.children_counter.to_i - 1)
  end

  def study_name
    if self.study
      self.study.name
    else
      "Нет информации"
    end
  end

  def set_age
    days_from_birth = (Date.today - self.birthday).to_i
    self.age = (days_from_birth / 365.25).to_i
  end

  def name
    second_name + ' ' + first_name + ' ' + last_name
  end
end
