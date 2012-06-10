class Trusty < ActiveRecord::Base
  belongs_to :family
  belongs_to :health,   :class_name => "GroupOption"
  
  before_save :set_age

  def set_age
    days_from_birth = (Date.today - self.birthday).to_i
    self.age = (days_from_birth / 365.25).to_i
  end
end
