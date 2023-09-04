require "rails_helper"

RSpec.describe Section, type: :model do
  context "validate create a section" do
    it "a section doesn't be void" do
      expect(Section.new).to_not be_valid
    end

    it "a section doesn't be letter void" do
      expect(Section.create(letter: nil)).to_not be_valid
      expect(Section.create(letter: "")).to_not be_valid
    end

    it "a section doesn't have string with greater two letter" do
      name_not_valid = "name-section-1"
      expect(Section.create(letter: name_not_valid)).to_not be_valid
    end

    it "save section unique and convert string lowercase to upcase" do
      name_valid = "a"
      section = Section.create(letter: name_valid)

      expect(section).to be_valid
      expect(section.letter).to eq(name_valid.upcase)
      expect(Section.create(letter: name_valid)).to_not be_valid
      expect(Section.create(letter: name_valid.upcase)).to_not be_valid
    end
  end
end
