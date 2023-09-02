class UsersRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates :role_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :role_id }
end
