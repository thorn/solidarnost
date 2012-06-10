# -*- encoding: utf-8 -*-
class Family < ActiveRecord::Base
  has_one :father       , :dependent => :destroy
  has_one :mother       , :dependent => :destroy
  has_one :trusty       , :dependent => :destroy
  has_many :children    , :dependent => :destroy
  has_many :visits      , :dependent => :destroy
  has_many :family_helps, :dependent => :destroy

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
  belongs_to :city
  belongs_to :home,     :class_name => "GroupOption"
  belongs_to :resource, :class_name => "GroupOption"
  belongs_to :source,   :class_name => "GroupOption"
  accepts_nested_attributes_for :father  , :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
  accepts_nested_attributes_for :mother  , :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
  accepts_nested_attributes_for :trusty  , :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
  accepts_nested_attributes_for :children, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }


  has_many :family_necessities
  has_many :necessities, :through => :family_necessities

  has_many :users_families
  has_many :users, :through => :users_families


  before_save :set_source_id
  before_update :set_source_id

  before_save :set_priority

  attr_reader :user_tokens
  attr_reader :necessity_tokens

  def city_name
    if self.city
      self.city.name
    else
      "Город не указан"
    end
  end

  def user_tokens=(ids)
    self.user_ids = ids
  end

  def necessity_tokens=(ids)
    self.necessity_ids = ids
  end

  def descript
    if self.description.nil? then self.description else "Нет описания" end
  end

  def set_priority
    self.priority = ((self.home.coeff/10)*35) + ((self.resource.coeff/10)*25) + ((self.source.coeff/10)*15)
  end

  def priority
    ((self.home.coeff/10)*35) + ((self.resource.coeff/10)*25) + ((self.source.coeff/10)*15)
  end

  def set_source_id
    m_per_member = source_amount / member_count
    for option in GroupOption.source do
      if m_per_member >= option.amount_start and m_per_member <= option.amount_end
        self.source_id = option.id
        return nil
      end
    end
    self.source_id = GroupOption.source.first.id
  end

  def member_count
    f_c = if self.father then 1 else 0 end
    m_c = if self.mother then 1 else 0 end
    t_c = if self.trusty then 1 else 0 end
    c_c = self.children.count
    res = f_c + m_c + t_c + c_c
    if res == 0 then 1 else res end
  end
end
