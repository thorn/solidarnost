#-*- encoding: utf-8 -*-
class Group < ActiveRecord::Base
  has_many :group_options, dependent: :destroy
  scope :for_families, where(for_people: false)
  scope :for_people,   where(for_people: true)
  scope :visible,      where(important: true)
  scope :for_show,     where(hidden: false)
  scope :for_admin,    where(hidden: true)
  belongs_to :setting

  def for_admin?
    hidden == true
  end

  def setting_name
    if setting
      "#{setting.name}:#{setting.value}:#{setting.start}:#{setting.end}"
    else
      "Нет настройки"
    end
  end
end
