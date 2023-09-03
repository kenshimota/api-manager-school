require "rails_helper"

RSpec.describe Subject, type: :model do
  context "validate create a subject" do
    it "a subject doesn't be void" do
      expect(Subject.new).to_not be_valid
    end

    it "a subject doesn't be name void" do
      expect(Subject.create(name: nil)).to_not be_valid
      expect(Subject.create(name: "")).to_not be_valid
    end

    it "save subject unique" do
      name = "name-subject-1"
      expect(Subject.create(name: name)).to be_valid
      expect(Subject.create(name: name)).to_not be_valid
      expect(Subject.create(name: name.upcase)).to_not be_valid
    end
  end
end
