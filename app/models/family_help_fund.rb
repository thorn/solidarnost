class FamilyHelpFund < ActiveRecord::Base
  belongs_to :fund
  belongs_to :family_help
end
