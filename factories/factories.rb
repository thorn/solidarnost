#-*- encoding: utf-8 -*-
FactoryGirl.define do
  factory :group do
    name
    coeff 20
  end

  factory :group_option do
    name
    coeff 20
    association :group, factory: :group
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :name do |n|
    "name#{n}"
  end
end
