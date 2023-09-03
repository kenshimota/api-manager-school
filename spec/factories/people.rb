FactoryBot.define do
  factory :person do
    name do
      str = ""

      while str.length < 3
        str = Faker::Name.first_name
      end

      str
    end

    last_name { Faker::Name.last_name }
    phone_code { Faker::Number.number(digits: 3) }
    phone_number { Faker::Number.number(digits: 10) }
    identity_document { Faker::Number.number(digits: 10) }
  end
end
