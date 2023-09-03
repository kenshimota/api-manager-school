require_relative "seeds/development/seeds.rb"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

rails_env = ENV["RAILS_ENV"] || "development"

role_names = [
  USERS_ROLES_CONST[:student],
  USERS_ROLES_CONST[:manager],
  USERS_ROLES_CONST[:profesor],
  USERS_ROLES_CONST[:representative],
]

role_names.each do |name|
  Role.find_or_create_by(name: name)
end

if rails_env == "development"
  puts "Install Seed Development"
  execute_development
end
