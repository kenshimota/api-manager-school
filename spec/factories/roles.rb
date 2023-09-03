FactoryBot.define do
  factory :role_manager, class: Role do
    name { USERS_ROLES_CONST[:manager] }
  end

  factory :role_student, class: Role do
    name { USERS_ROLES_CONST[:student] }
  end

  factory :role_representative, class: Role do
    name { USERS_ROLES_CONST[:representative] }
  end

  factory :role_profesor, class: Role do
    name { USERS_ROLES_CONST[:profesor] }
  end
end
