# -*- encoding: utf-8 -*-
require "date"
class Child < ActiveRecord::Base
  belongs_to :family

  belongs_to :health,   :class_name => "GroupOption"
  before_save :set_age

  belongs_to :study, :class_name => "StudyCategory", :foreign_key => "study_id"

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
end
