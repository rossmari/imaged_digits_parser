# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'MAGIC THE GATHERING: 5th Edition', value: 1015)
AdminUser.create!(email: 'admin@admin.ru', password: 'gfhjkmqe', password_confirmation: 'gfhjkmqe')