class FamilyCoeff < ActiveRecord::Base
  belongs_to :family
  belongs_to :group_option
end
