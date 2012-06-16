FactoryGirl.define do
  factory :group_option do
    name
    coeff 20
  end

  factory :group do
    name

  end


  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :name do |n|
    "name#{n}"
  end
end
