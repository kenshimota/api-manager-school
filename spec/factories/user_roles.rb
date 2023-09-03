FactoryBot.define do
  factory :user_role_manager, class: UsersRole do
    role { FactoryBot.create(:role_manager) }
    user { FactoryBot.create(:user_manager) }
  end

  factory :user_role_student, class: UsersRole do
    role { FactoryBot.create(:role_student) }
    user { FactoryBot.create(:user_student) }
  end
end
