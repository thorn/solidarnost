class Father < ActiveRecord::Base
  belongs_to :family, counter_cache: :member_counter
  belongs_to :health, class_name: "GroupOption"

  before_save :set_age
  before_create :increment_counter
  before_destroy :decrement_counter

  def increment_counter
    family.update_attribute(:father_counter, 1)
  end

  def decrement_counter
    family.update_attribute(:father_counter, 0)
  end

  def set_age
    days_from_birth = (Date.today - self.birthday).to_i
    self.age = (days_from_birth / 365.25).to_i
  end

  def name
    first_name + " " + last_name
  end
end
