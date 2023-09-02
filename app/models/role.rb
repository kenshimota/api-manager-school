class Role < ApplicationRecord
  has_many :users, through: :users_roles
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
