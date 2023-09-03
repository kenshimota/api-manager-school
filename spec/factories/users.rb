FactoryBot.define do
  factory :user do
    password { "m4nAgeR." }
    email { Faker::Internet.email }
    person { FactoryBot.create(:person) }
  end
end
