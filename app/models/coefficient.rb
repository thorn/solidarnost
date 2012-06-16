class Coefficient < ActiveRecord::Base
  belongs_to :group_option
  belongs_to :coefficientable, polymorphic: true
end
