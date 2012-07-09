#-*- encoding: utf-8 -*-
class Setting < ActiveRecord::Base
  scope :priority, where(group_name: "Приоритет")
end
