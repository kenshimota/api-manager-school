class ResourceProtectedController < ApplicationController
  before_action :authenticate_user!

  private

  def auth_only_user_adults
    role_names = [USERS_ROLES_CONST[:manager], USERS_ROLES_CONST[:profesor], USERS_ROLES_CONST[:representative]]
    is_allow = does_user_have_roles role_names

    if is_allow == false
      return render json: { message: "don't allow this url", error: true, success: false }, status: :forbidden
    end
  end

  def auth_only_user_academyc
    role_names = [USERS_ROLES_CONST[:manager], USERS_ROLES_CONST[:profesor]]
    is_allow = does_user_have_roles role_names

    if is_allow == false
      return render json: { message: "don't allow this url", error: true, success: false }, status: :forbidden
    end
  end

  def does_user_have_roles(roles)
    is_allow = false
    @current_user = current_user
    current_roles = @current_user.roles
    roles = Set.new(roles)

    i = 0
    while !is_allow and i < current_roles.length
      role_name = current_roles[i].name
      is_allow = roles.include?(role_name)
      i += 1
    end

    is_allow
  end

  # Show errors
  def show_error(model)
    render json: { errors: model.errors }, status: :unprocessable_entity
  end
end
