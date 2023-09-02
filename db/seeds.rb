# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

rails_env = ENV["RAILS_ENV"] || "development"

["student", "manager", "representative", "profesor"].each do |name|
  Role.find_or_create_by(name: name)
end

class PeopleCreatorDevelopment
  def initialize()
    @identity_memory = Set.new
  end

  def create_person
    phone_code = Faker::Number.number(digits: 3)
    phone_number = Faker::Number.number(digits: 10)
    identity_document = Faker::Number.number(digits: 10)

    data = {
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_code: phone_code,
      phone_number: phone_number,
      identity_document: identity_document,
    }

    while @identity_memory.include?(identity_document)
      identity_document = Faker::Number.number(digits: 10)
    end

    @identity_memory << identity_document
    Person.create(data)
  end
end

if rails_env == "development"
  person_creator = PeopleCreatorDevelopment.new

  data_users = [
    { email: "admin1@example.com", password: "managEr1.", role: Role.find_by(name: "manager"), person: nil },
    { email: "admin2@example.com", password: "managEr1.", role: Role.find_by(name: "profesor"), person: nil },
    { email: "admin3@example.com", password: "managEr1.", role: Role.find_by(name: "student"), person: nil },
    { email: "admin4@example.com", password: "managEr1.", role: Role.find_by(name: "representative"), person: nil },
  ]

  data_users.each do |user_data|
    current_user = User.find_by(email: user_data[:email])
    if !current_user
      user_data[:person] = person_creator.create_person
      User.create(user_data)
    end
  end
end
