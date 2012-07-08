class Group < ActiveRecord::Base
  has_many :group_options, :dependent => :destroy
  scope :for_families, where(for_people: false)
  scope :for_people,   where(for_people: true)
  scope :visible,      where(important: true)
end
