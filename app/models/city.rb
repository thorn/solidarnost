class City < ActiveRecord::Base
  has_many  :families, :dependent => :destroy
end
