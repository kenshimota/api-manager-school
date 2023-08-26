require "faker"
require "rails_helper"

RSpec.describe User, type: :model do
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

  context "validate create a user" do
    it "a user doesn't be void" do
      expect(User.new).to_not be_valid
    end

    it "check if the email user is" do
      expect(User.create(email: nil, password: password, role: role, person: person)).to_not be_valid
      expect(User.create(email: "", password: password, role: role, person: person)).to_not be_valid
      expect(User.create(email: "hola", password: password, role: role, person: person)).to_not be_valid
    end

    it "check if the password user is validate" do
      expect(User.create(email: email, password: nil, role: role, person: person)).to_not be_valid
      expect(User.create(email: email, password: "", role: role, person: person)).to_not be_valid
      expect(User.create(email: email, password: "1234567", role: role, person: person)).to_not be_valid
      expect(User.create(email: email, password: "manager", role: role, person: person)).to_not be_valid
      expect(User.create(email: email, password: "manager*", role: role, person: person)).to_not be_valid
      expect(User.create(email: email, password: "1manager*", role: role, person: person)).to_not be_valid
    end

    it "save user unique" do
      expect(User.create(email: email, password: password, role: role, person: person)).to be_valid
      expect(User.create(email: email, password: password, role: role, person: person)).to_not be_valid
    end
  end
end
