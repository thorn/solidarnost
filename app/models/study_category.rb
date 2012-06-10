class StudyCategory < ActiveRecord::Base
  has_many :children, :dependent => :nullify
end
