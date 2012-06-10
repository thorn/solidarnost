class StudyCategory < ActiveRecord::Base
  has_many :children, :dependent => :nullify, foreign_key: "study_id"
end
