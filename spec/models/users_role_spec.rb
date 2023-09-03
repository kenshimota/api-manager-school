require "faker"
require "rails_helper"

RSpec.describe UsersRole, type: :model do
  let(:password) { "m4nAgeR." }
  let(:email) { Faker::Internet.email }
  let(:person) { FactoryBot.create(:person) }
  let(:role) { FactoryBot.create(:role_manager) }
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
