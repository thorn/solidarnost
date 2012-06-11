# -*- encoding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Creating roles"
Role.delete_all
roles = ["admin", "operator", "user"]
roles.each do |role|
  Role.create(name: role)
end

puts "Creating admin user"
User.destroy_all
admin = User.create(email: "admin@example.com", password: "password", name: "admin", address: "admin", phone:"admin")
admin.role_ids = [Role.find_by_name("admin").id]

puts "Creating groups"
groups = ["source", "resource", "home", "health"]
groups.each do |name|
  Group.create(name: name)
end

puts "Creating group options"
GroupOption.destroy_all
group_options = [
  {name: "Здоров",                           coeff: 0 , group_id: Group.find_by_name("health").id   },
  {name: "Инвалид (не требует лечения)",     coeff: 14, group_id: Group.find_by_name("health").id   },
  {name: "Нуждается в поддержании здоровья", coeff: 21, group_id: Group.find_by_name("health").id   },
  {name: "Нуждается в срочном лечении",      coeff: 35, group_id: Group.find_by_name("health").id   },
  {name: "Достаточное",                      coeff: 0 , group_id: Group.find_by_name("resource").id },
  {name: "Недостаточное",                    coeff: 12, group_id: Group.find_by_name("resource").id },
  {name: "Недостаточно еды",                 coeff: 18, group_id: Group.find_by_name("resource").id },
  {name: "Отсутствует (очень плохое)",       coeff: 30, group_id: Group.find_by_name("resource").id },
  {name: "Собственное",                      coeff: 0 , group_id: Group.find_by_name("home").id     },
  {name: "Съемное жилье",                    coeff: 10, group_id: Group.find_by_name("home").id     },
  {name: "Приют",                            coeff: 15, group_id: Group.find_by_name("home").id     },
  {name: "Негде жить",                       coeff: 25, group_id: Group.find_by_name("home").id     },
  {name: "Выше минимума",                    coeff: 0 , group_id: Group.find_by_name("source").id, amount_start: 8000, amount_end: 10000},
  {name: "Минимум",                          coeff: 4 , group_id: Group.find_by_name("source").id, amount_start: 4000, amount_end: 8000 },
  {name: "Ниже минимума",                    coeff: 6 , group_id: Group.find_by_name("source").id, amount_start: 0, amount_end: 4000 },
  {name: "Отсутствуют",                      coeff: 10, group_id: Group.find_by_name("source").id, amount_start: 0, amount_end: 0}
]
group_options.each do |attr|
  GroupOption.create(attr)
end

puts "Creating help types"
HelpType.destroy_all
help_types = ["Продуктовая помощь", "Денежная помощь", "Жилищная помощь"]
help_types.each do |type|
  HelpType.create(name: type)
end

puts "Creating study categories"
StudyCategory.destroy_all
study_categories = ["Среднее", "Незаконченное среднее", "Высшее", "Незаконченное высшее", "Нет образования"]
study_categories.each do |name|
  StudyCategory.create(name: name)
end

puts "Creating cities"
City.destroy_all
cities = ["Хасавюрт", "Махачкала", "Дербент", "Кизилюрт", "Кизляр", "Избербаш", "Каспийск", "Дагестанские огни"]
cities.each do |name|
  City.create(name: name)
end
