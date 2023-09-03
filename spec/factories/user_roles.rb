FactoryBot.define do
  factory :user_role_manager, class: UsersRole do
    role { FactoryBot.create(:role_manager) }
    user { FactoryBot.create(:user) }
  end

  factory :user_role_student, class: UsersRole do
    role { FactoryBot.create(:role_student) }
    user { FactoryBot.create(:user) }
  end

  factory :user_role_profesor, class: UsersRole do
    role { FactoryBot.create(:role_profesor) }
    user { FactoryBot.create(:user) }
  end

  factory :user_role_representative, class: UsersRole do
    role { FactoryBot.create(:role_representative) }
    user { FactoryBot.create(:user) }
  end
end
