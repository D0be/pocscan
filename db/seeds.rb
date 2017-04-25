# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name  = Faker::Name.name
  user_id = 1
  description = "This is test data"
  type_id = 1
  level_id = 1
  search_key = "Port: 80"
  file = "test_vul.rb"
  Vul.create!(name:  name,
  			   user_id: user_id,
               description: description,
               type_id: type_id,
               level_id: level_id,
               search_key: search_key,
               file: file)
end

10.times do |n|
  name  = Faker::Name.name
  user_id = 1
  description = "This is test data"
  type_id = 1
  level_id = 2
  search_key = "Port: 80"
  file = "test_vul.rb"
  Vul.create!(name:  name,
  			   user_id: user_id,
               description: description,
               type_id: type_id,
               level_id: level_id,
               search_key: search_key,
               file: file)
end

10.times do |n|
  name  = Faker::Name.name
  user_id = 1
  description = "This is test data"
  type_id = 2
  level_id = 1
  search_key = "Port: 80"
  file = "test_vul.rb"
  Vul.create!(name:  name,
  			   user_id: user_id,
               description: description,
               type_id: type_id,
               level_id: level_id,
               search_key: search_key,
               file: file)
end