require_relative "PeopleCreatorDevelopment.rb"

def execute_development
  person_creator = PeopleCreatorDevelopment.new

  data_users = [
    { email: "admin1@example.com", password: "managEr1.", roles: [Role.find_by(name: USERS_ROLES_CONST[:manager])] },
    { email: "admin2@example.com", password: "managEr1.", roles: [Role.find_by(name: USERS_ROLES_CONST[:profesor])] },
    { email: "admin3@example.com", password: "managEr1.", roles: [Role.find_by(name: USERS_ROLES_CONST[:student])] },
    { email: "admin4@example.com", password: "managEr1.", roles: [Role.find_by(name: USERS_ROLES_CONST[:representative])] },
  ]

  data_users.each do |user_data|
    current_user = User.find_by(email: user_data[:email])

    if !current_user
      current_user = User.create(
        email: user_data[:email],
        password: user_data[:password],
        person: person_creator.create_person,
      )

      user_data[:roles].each { |role| UsersRole.create(user: current_user, role: role) }
    end
  end
end
