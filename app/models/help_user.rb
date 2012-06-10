class HelpUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :family_help
end
