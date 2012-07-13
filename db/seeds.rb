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
Group.destroy_all
groups = [
          {name:"health",       coeff: 15, for_people: true,  important: false},
          {name:"Холодильник",  coeff: 15, for_people: false, important: false},
          {name:"Мебель",       coeff: 10, for_people: false, important: false},
          {name:"Телевизор",    coeff: 4, for_people: false, important: false},
          {name:"Скот",         coeff: 10, for_people: false, important: false},
          {name:"Вода",         coeff: 15, for_people: false, important: false},
          {name:"Канализация",  coeff: 15, for_people: false, important: false},
          {name:"Кухня",        coeff: 15, for_people: false, important: false},
          {name:"Ванная",       coeff: 15, for_people: false, important: false},
          {name:"Туалет",       coeff: 15, for_people: false, important: false},
          {name:"Морозильник",  coeff: 04, for_people: false, important: false},
          {name:"Жилье",        coeff: 25, for_people: false, important: false},
          {name:"Автомобиль",   coeff: 04, for_people: false, important: false},
          {name:"Питание",      coeff: 30, for_people: false, important: true},
          {name:"Компьютер",    coeff: 04, for_people: false, important: false},
          {name:"Зависимость",  coeff: 03, for_people: false, important: false},
          {name:"Отопление",    coeff: 15, for_people: false, important: false},
          {name:"Печь",         coeff: 15, for_people: false, important: false},
          {name:"Здоровье",     coeff: 15, for_people: false, important: false},
          {name:"Ремонт",       coeff: 10, for_people: false, important: true},
          {name:"Пашня/огород", coeff: 10, for_people: false, important: false},
          {name:"Мнение визитера",      coeff: 106, for_people: false, important: true},
          {name:"Одежда/Украшения",     coeff: 010, for_people: false, important: false},
          {name:"Средства гигиены",     coeff: 010, for_people: false, important: false},
          {name:"Стиральная машина",    coeff: 8, for_people: false, important: false},
          {name:"Жилищная проблема",    coeff: 000, for_people: false, important: true},
          {name:"Ежемесячная помощь",   coeff: 000, for_people: false, important: true},
          {name:"Юридическая проблема", coeff: 000, for_people: false, important: true},
          {name:"Медицинская проблема", coeff: 000, for_people: false, important: true},
          {name:"Морально психологическая обстановка", coeff: 0, for_people: false, important: true}]
groups.each do |attr|
  Group.create(attr)
end

puts "Creating group options"
GroupOption.destroy_all
group_options = [
{name: "0",coeff: 0, group_id: Group.find_by_name("Компьютер").id},
{name: "2",coeff: 120, group_id: Group.find_by_name("Компьютер").id},
{name: "Здоров",coeff: 60, group_id: Group.find_by_name("health").id},
{name: "Болеет",coeff: 40, group_id: Group.find_by_name("health").id},
{name: "Нуждается в срочном лечении",coeff: 0, group_id: Group.find_by_name("health").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Автомобиль").id},
{name: "1",coeff: 70, group_id: Group.find_by_name("Автомобиль").id},
{name: "2",coeff: 140, group_id: Group.find_by_name("Автомобиль").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Ванная").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Ванная").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Ванная").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Вода").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Вода").id},
{name: "2",coeff: 60, group_id: Group.find_by_name("Вода").id},
{name: "Есть",coeff: 0, group_id: Group.find_by_name("Жилищная проблема").id},
{name: "Нет",coeff: 0, group_id: Group.find_by_name("Жилищная проблема").id},
{name: "Свое",coeff: 100, group_id: Group.find_by_name("Жилье").id},
{name: "Арендует",coeff: 70, group_id: Group.find_by_name("Жилье").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Канализация").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Канализация").id},
{name: "2",coeff: 60, group_id: Group.find_by_name("Канализация").id},
{name: "2",coeff: 80, group_id: Group.find_by_name("Кухня").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Кухня").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Кухня").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Мебель").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Мебель").id},
{name: "2",coeff: 120, group_id: Group.find_by_name("Мебель").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Здоровье").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Здоровье").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Здоровье").id},
{name: "Есть",coeff: 0, group_id: Group.find_by_name("Медицинская проблема").id},
{name: "Нет",coeff: 0, group_id: Group.find_by_name("Медицинская проблема").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Морозильник").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Морозильник").id},
{name: "2",coeff: 120, group_id: Group.find_by_name("Морозильник").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Пашня/огород").id},
{name: "0",coeff: 10, group_id: Group.find_by_name("Пашня/огород").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Пашня/огород").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Печь").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Печь").id},
{name: "2",coeff: 100, group_id: Group.find_by_name("Печь").id},
{name: "Достаточное",coeff: 100, group_id: Group.find_by_name("Питание").id},
{name: "Не достаточное",coeff: 0, group_id: Group.find_by_name("Питание").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Зависимость").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Зависимость").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Зависимость").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Ремонт").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Ремонт").id},
{name: "2",coeff: 120, group_id: Group.find_by_name("Ремонт").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Скот").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Скот").id},
{name: "0",coeff: 10, group_id: Group.find_by_name("Скот").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Телевизор").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Телевизор").id},
{name: "2",coeff: 100, group_id: Group.find_by_name("Телевизор").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Туалет").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Туалет").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Туалет").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Холодильник").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Холодильник").id},
{name: "2",coeff: 120, group_id: Group.find_by_name("Холодильник").id},
{name: "Есть",coeff: 0, group_id: Group.find_by_name("Юридическая проблема").id},
{name: "Нет",coeff: 0, group_id: Group.find_by_name("Юридическая проблема").id},
{name: "да",coeff: 0, group_id: Group.find_by_name("Ежемесячная помощь").id},
{name: "нет",coeff: 0, group_id: Group.find_by_name("Ежемесячная помощь").id},
{name: "Есть",coeff: 0, group_id: Group.find_by_name("Морально психологическая обстановка").id},
{name: "Нет",coeff: 0, group_id: Group.find_by_name("Морально психологическая обстановка").id},
{name: "1",coeff: -12, group_id: Group.find_by_name("Мнение визитера").id},
{name: "1",coeff: 60, group_id: Group.find_by_name("Компьютер").id},
{name: "0",coeff: 30, group_id: Group.find_by_name("Мнение визитера").id},
{name: "2",coeff: -35, group_id: Group.find_by_name("Мнение визитера").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Одежда/Украшения").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Одежда/Украшения").id},
{name: "2",coeff: 120, group_id: Group.find_by_name("Одежда/Украшения").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Средства гигиены").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Средства гигиены").id},
{name: "2",coeff: 100, group_id: Group.find_by_name("Средства гигиены").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Стиральная машина").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Стиральная машина").id},
{name: "2",coeff: 80, group_id: Group.find_by_name("Стиральная машина").id},
{name: "0",coeff: 0, group_id: Group.find_by_name("Отопление").id},
{name: "1",coeff: 40, group_id: Group.find_by_name("Отопление").id},
{name: "2",coeff: 70, group_id: Group.find_by_name("Отопление").id},
{name: "Приют",coeff: 0, group_id: Group.find_by_name("Жилье").id}
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
cities = ["Хасавюрт", "Махачкала", "Дербент", "Кизилюрт", "Кизляр", "Избербаш", "Каспийск", "Дагестанские огни", "4-й поселок", "Агачаул", "Альбурикент", "Анжи базар", "Вокзал", "Караман", "Восточный", "Ипподром", "Киргу", "Космос", "Красноармейск", "Кривая балка", "п. Кяхулай", "Ленинкент", "Тарки", "Научный городок", "5-й поселок", "1-я Махачкала", "Центр", "Семендер", "Старая автостанция", "Сепараторный", "Троллейбусное кольцо", "п. Турали", "п. Тюбе", "Узбекгородок", "Учхоз", "п. Хушет", "Центральная мечеть", "п. Шамхал", "Южная автостанция", "МЖС"]
cities.each do |name|
  City.create(name: name)
end

puts "Creating settings"
Setting.delete_all
settings = [
  {group_name: "Приоритет", name: 0, start: 0, end: 800, value: "red"},
  {group_name: "Приоритет", name: 1, start: 800, end: 1200, value:  "blue"},
  {group_name: "Приоритет", name: 2, start: 1200, end:  5000, value:  "green"}
]
for setting in settings do
  Setting.create(setting)
end
