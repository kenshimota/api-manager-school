require "faker"
require "rails_helper"

RSpec.describe User, type: :model do
  let(:password) { "m4nAgeR." }
  let(:email) { Faker::Internet.email }
  let(:person) { FactoryBot.create(:person) }

  context "validate create a user" do
    it "a user doesn't be void" do
      expect(User.new).to_not be_valid
    end

    it "check if the email user is" do
      expect(User.create(email: nil, password: password, person: person)).to_not be_valid
      expect(User.create(email: "", password: password, person: person)).to_not be_valid
      expect(User.create(email: "hola", password: password, person: person)).to_not be_valid
    end

    it "check if the password user is validate" do
      expect(User.create(email: email, password: nil, person: person)).to_not be_valid
      expect(User.create(email: email, password: "", person: person)).to_not be_valid
      expect(User.create(email: email, password: "1234567", person: person)).to_not be_valid
      expect(User.create(email: email, password: "manager", person: person)).to_not be_valid
      expect(User.create(email: email, password: "manager*", person: person)).to_not be_valid
      expect(User.create(email: email, password: "1manager*", person: person)).to_not be_valid
    end

    it "a user can't be to save while don't have a person" do
      person_void = Person.new
      expect(User.create(email: email, password: password, person: nil)).to_not be_valid
      expect(User.create(email: email, password: password, person: person_void)).to_not be_valid
    end

    it "save user unique" do
      expect(User.create(email: email, password: password, person: person)).to be_valid
      expect(User.create(email: email, password: password, person: person)).to_not be_valid
    end
  end
end
