class VisitFund < ActiveRecord::Base
  belongs_to :fund
  belongs_to :visit
end
