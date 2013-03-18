# -*- encoding: utf-8 -*-
class Family < ActiveRecord::Base

  before_save :set_priority

  def set_priority
    self.priority = group_options.includes(:group).inject(0){ |sum, go| sum += go.coeff * go.group.coeff/10 }
  end

  def process_visits(params)
    if params[:visit_date] != '' and params[:make_visit] == "true"
      visits.create(title: "Мониторинг семьи", visit_date: params[:visit_date], made_at: params[:visit_date] , user_ids: params[:volunteer_tokens])
      self.persist!
    end
  end

  NOT_PERSISTED = 0
  PERSISTED = 1

  scope :with_children, lambda{
    joins(:children).
    where("children.family_id IS NOT ?", nil)
  }
  scope :without_children, lambda{
    joins("LEFT JOIN children ON children.family_id=families.id")
    .where('children.family_id IS ?', nil )
  }
  scope :without_father, lambda{
    joins("LEFT JOIN fathers ON fathers.family_id=families.id")
    .where('fathers.family_id IS ?', nil)
  }
  scope :without_mother, lambda{
    joins("LEFT JOIN mothers ON mothers.family_id=families.id")
    .where('mothers.family_id IS ?', nil)
  }
  scope :with_one_parent, lambda{
    find_by_sql('SELECT "families".* FROM "families" LEFT JOIN fathers ON fathers.family_id=families.id WHERE (fathers.family_id IS NULL)
      UNION
      SELECT "families".* FROM "families" LEFT JOIN mothers ON mothers.family_id=families.id WHERE (mothers.family_id IS NULL)')
  }

  def self.by_colour(setting)
    low_end = setting.start
    high_end = setting.end
    where("priority >= ? AND priority < ?", low_end, high_end)
  end

  has_one  :father      , dependent: :destroy
  has_one  :mother      , dependent: :destroy
  has_one  :trusty      , dependent: :destroy
  has_many :children    , dependent: :destroy
  has_many :family_members    , dependent: :destroy
  has_many :visits      , dependent: :destroy
  has_many :family_helps, dependent: :destroy

  has_many :family_necessities
  has_many :necessities, through: :family_necessities

  has_many :users_families
  has_many :users, through: :users_families

  has_many :coefficients, as: :coefficientable
  has_many :group_options, through: :coefficients
  has_many :groups, through: :group_options

  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  has_many :incomes
  accepts_nested_attributes_for :incomes, allow_destroy: true
  has_many :expenses
  accepts_nested_attributes_for :expenses, allow_destroy: true

  belongs_to :city
  belongs_to :area

  belongs_to :home,     :class_name => "GroupOption"
  belongs_to :resource, :class_name => "GroupOption"
  belongs_to :source,   :class_name => "GroupOption"

  accepts_nested_attributes_for :father  , allow_destroy: true, reject_if: lambda { |a| a[:first_name].blank? }
  accepts_nested_attributes_for :mother  , allow_destroy: true, reject_if: lambda { |a| a[:first_name].blank? }
  accepts_nested_attributes_for :trusty  , allow_destroy: true, reject_if: lambda { |a| a[:first_name].blank? }
  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: lambda { |a| a[:first_name].blank? }
  accepts_nested_attributes_for :family_members, allow_destroy: true, reject_if: lambda { |a| a[:first_name].blank? }

  attr_reader :user_tokens
  attr_reader :necessity_tokens
  attr_accessor :volunteer_tokens
  attr_accessor :visit_date
  attr_accessor :make_visit

  attr_writer :sirota

  def sirota
    mother_counter == 0 and father_counter == 0 and children > 0
  end

  def user_tokens=(ids)
    self.user_ids = ids
  end

  def necessity_tokens=(ids)
    self.necessity_ids = ids
  end

  def city_name
    city ? city.name : "Город не указан"
  end

  def full_city_name
    return city_name unless city
    parents = get_parents
    parents.inject("") do |res, city|
      name = (city == parents.last) ? city.name : "#{city.name}/"
      res << name
    end
  end

  def area_name
    area ? area.name : "Нет"
  end

  def persists?
    status == PERSISTED
  end

  def unpersist!
    update_attribute(:status, NOT_PERSISTED)
  end

  def persist!
    update_attribute(:status, PERSISTED)
  end

  def get_parents
    parents = [city]
    c = city
    while (c = c.parent) and (c.name != "Респ. Дагестан")
      parents << c
    end
    parents.reverse!
  end

  def self.status_for_select
    [
      ['Заявка', Family::NOT_PERSISTED],
      ['Постоянная', Family::PERSISTED]
    ]
  end
end
