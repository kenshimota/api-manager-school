FactoryBot.define do
  factory :role_manager, class: Role do
    name { "manager" }
  end

  factory :role_student, class: Role do
    name { "student" }
  end
end
