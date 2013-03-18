#-*- encoding: utf-8 -*-
class Setting < ActiveRecord::Base
  scope :layout, where(group_name: "layout")
  scope :priority, where(group_name: "Приоритет")
  scope :incomes, where(group_name: "income")
  scope :expenses, where(group_name: "expense")
  has_many :groups, dependent: :nullify
  has_many :transactions
end
