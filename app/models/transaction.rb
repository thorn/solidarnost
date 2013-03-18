class Transaction < ActiveRecord::Base
  belongs_to :family
  belongs_to :setting
end
