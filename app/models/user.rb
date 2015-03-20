#-*- encoding: utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :address, :city_id, :profession, :description, :role_ids, :fund_id

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :users_families
  has_many :families, through: :users_families

  belongs_to :city
  belongs_to :fund

  validates :name, :phone, :address, presence: true

  before_create :set_role
  has_many :created_families, foreign_key: "creator_id", class_name: "Family"

  def role_symbols
    (roles || []).map {|r| r.name.to_sym}
  end

  def city_name
    if self.city
      self.city.name
    else
      ""
    end
  end

  def to_json(options=nil)
    super (options || {}).merge(
      only: [:id],
      methods: [:name])
  end

  def user_info
    if fund
      "#{name} фонд: #{fund.name}"
    else
      name
    end
  end
private

  def set_role
    self.user_roles.build(role_id: Role.find_by_name("user").id)
  end
end
