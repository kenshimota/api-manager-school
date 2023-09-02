require "faker"
require "rails_helper"

RSpec.describe UsersRole, type: :model do
  let(:password) { "m4nAgeR." }
  let(:email) { Faker::Internet.email }
  let(:role) { Role.create(name: "role-name-1") }
  let(:phone_code) { Faker::Number.number(digits: 3) }
  let(:phone_number) { Faker::Number.number(digits: 10) }
  let(:identity_document) { Faker::Number.number(digits: 10) }

  let(:person) {
    Person.create(
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_code: phone_code,
      phone_number: phone_number,
      identity_document: identity_document,
    )
  }

  let(:user) { User.create(email: email, password: password, person: person) }

  context "validate create a users_role" do
    it "a users_role doesn't be void" do
      expect(UsersRole.new).to_not be_valid
    end

    it "a users_role can't a field void" do
      expect(UsersRole.new(role: role)).to_not be_valid
      expect(UsersRole.new(user: user)).to_not be_valid
    end

    it "a users_role can't be repeated" do
      expect(UsersRole.create(role: role, user: user)).to be_valid
      expect(UsersRole.create(role: role, user: user)).to_not be_valid
    end
  end
end
