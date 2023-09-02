require "rails_helper"

RSpec.describe Student, type: :model do
  let(:password) { "m4nAgeR." }
  let(:email) { Faker::Internet.email }
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

  context "validate create a student" do
    it "a student doesn't be void" do
      expect(Student.new).to_not be_valid
    end

    it "a student must have a birthday" do
      expect(Student.create(person: person)).to_not be_valid
    end

    it "a student have to be greater than 10 years" do
      birthday_not_valid = Date.current - 365 * 9
      expect(Student.create(person: person, birthday: birthday_not_valid)).to_not be_valid

      expect(Student.create(person: person, birthday: Date.current)).to_not be_valid

      birthday = Date.current - 365 * 10
      expect(Student.create(person: person, birthday: birthday)).to be_valid
    end

    it "can't exists two student with same person" do
      birthday = Date.current - 365 * 10
      expect(Student.create(person: person, birthday: birthday)).to be_valid
      expect(Student.create(person: person, birthday: birthday)).to_not be_valid
    end
  end
end
