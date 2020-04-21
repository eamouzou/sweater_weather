# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "yeayea@ok.com", password: "password",
  password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")

User.create(email: 'badexample@yoyo.com', password: 'no', password_confirmation: 'no')

User.create(email: 'example@yoyo.com', password: 'yes', password_confirmation: 'yes')
