class Group < ActiveRecord::Base
  has_many :group_options, :dependent => :destroy
end
