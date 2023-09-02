class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  belongs_to :person
  has_many :users_roles
  has_many :roles, through: :users_roles

  validates :person_id, presence: true
  validates :password, presence: true, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-.]).{8,}/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
