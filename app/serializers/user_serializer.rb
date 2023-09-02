class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :created_at, :person

  attribute :roles do |current_user|
    current_user.roles.map { |role| RoleSerializer.new(role).serializable_hash[:data][:attributes] }
  end
end
