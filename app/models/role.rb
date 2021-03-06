class Role < Dictionary
  has_many :user_roles
  has_many :users, through: :user_roles, dependent: :destroy
  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids
  end
end
