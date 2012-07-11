#-*- encoding: utf-8 -*-
class Setting < ActiveRecord::Base
  scope :layout, where(group_name: "layout")
  scope :priority, where(group_name: "Приоритет")
  has_one :group, dependent: :nullify
end
