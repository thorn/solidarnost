class Necessity < ActiveRecord::Base
  has_many :family_necessities
  has_many :families, :through => :family_necessities
end
