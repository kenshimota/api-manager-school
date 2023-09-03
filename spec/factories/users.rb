FactoryBot.define do
  factory :user_student, class: User do
    email { Faker::Internet.email }
    password { "m4nAgeR." }

    person {
      Person.create(
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone_code: 58,
        phone_number: 4167548963,
        identity_document: 17589154,
      )
    }
  end

  factory :user_manager, class: User do
    email { Faker::Internet.email }
    password { "m4nAgeR." }
    person {
      Person.create(
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone_code: 58,
        phone_number: 4167548963,
        identity_document: 17589154,
      )
    }
  end
end
