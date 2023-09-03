class ResourceProtectedController < ApplicationController
  before_action :authenticate_user!

  private

  def auth_only_roles
    is_allow = false
    roles = @roles
    @current_user = current_user
    current_roles = @current_user.roles
    roles = Set.new(["manager", "profesor"])

    i = 0
    while !is_allow and i < current_roles.length
      role_name = current_roles[i].name
      is_allow = roles.include?(role_name)
      i += 1
    end

    if is_allow == false
      return render json: { message: "don't allow this url", error: true, success: false }, status: :forbidden
    end
  end

  # Show errors
  def show_error(model)
    render json: { errors: model.errors }, status: :unprocessable_entity
  end
end
