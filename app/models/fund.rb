class Fund < Dictionary
  has_many :users

  has_many :help_funds
  has_many :family_helps, through: :help_funds

  has_many :visit_funds
  has_many :visits, through: :visit_funds
end
