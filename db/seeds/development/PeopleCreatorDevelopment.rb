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
