class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through => :user_roles
  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids
  end
end
