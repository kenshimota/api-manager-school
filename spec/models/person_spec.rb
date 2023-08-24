require "rails_helper"

RSpec.describe Person, type: :model do
  context "validate create a person" do
    it "a person void" do
      expect(Person.new).to_not be_valid
    end

    it "a person won't be valid without name or the person have a name with less 3 letters" do
      person1 = Person.new(name: "name", identity_document: 15465468, phone_code: 58, phone_number: 4165879525)
      person2 = Person.new(name: "name", last_name: "ho", identity_document: 15465468, phone_code: 58, phone_number: 4165879525)

      expect(person1).to_not be_valid
      expect(person2)
    end

    it "a person won't be valid without last_name or the person have a last_name with less 3 letters" do
      person1 = Person.new(last_name: "lastname", identity_document: 15465468, phone_code: 58, phone_number: 4165879525)
      person2 = Person.new(name: "na", last_name: "lastname", identity_document: 15465468, phone_code: 58, phone_number: 4165879525)

      expect(person1).to_not be_valid
      expect(person2).to_not be_valid
    end

    it "a person won't be valid without identity_document" do
      person1 = Person.new(last_name: "lastname", name: "name", phone_code: 58, phone_number: 4165879525)
      expect(person1).to_not be_valid
    end

    it "a person won't be valid without phone_number or phone_code" do
      person1 = Person.new(last_name: "lastname", name: "name", identity_document: 78126736, phone_code: nil, phone_number: nil)
      person2 = Person.new(last_name: "lastname", name: "name", identity_document: 78126736, phone_code: 5981, phone_number: 4785123654)
      person3 = Person.new(last_name: "lastname", name: "name", identity_document: 78126736, phone_code: 598, phone_number: 474785123654856)
      person4 = Person.new(last_name: "lastname", name: "name", identity_document: 78126736, phone_code: 58, phone_number: 4267372159)

      expect(person1).to_not be_valid
      expect(person2).to_not be_valid
      expect(person3).to_not be_valid
      expect(person4).to be_valid
    end

    it "a person won't be valid if his document identity has been registered" do
      identity_document = 15878978789

      person1 = Person.create(
        name: "name1",
        last_name: "lastname1",
        identity_document: identity_document,
        phone_code: 58,
        phone_number: 4165879525,
      )

      person2 = Person.create(
        name: "name2",
        last_name: "lastname2",
        identity_document: identity_document,
        phone_code: 58,
        phone_number: 4245687154,
      )

      expect(person1).to be_valid
      expect(person2).to_not be_valid
    end
  end
end
