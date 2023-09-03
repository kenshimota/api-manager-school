class StudentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :birthday, :person, :created_at
end
