# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
  email: "admin@gmail.com",
  password: "aaaaaa"
  )
  
Customer.create!(
  last_name: "aa",
  first_name: "aa",
  last_name_kana: "aa",
  first_name_kana: "aa",
  postal_code: "aa",
  address: "aa",
  telephone_number: "11",
  email: "bb@ab",
  password: "aaaaaa"
  )
  
  # Item.create!(
  # name: "test0",
  # introduction: "test0"
  # price: 500
  # is_active: true
  # )