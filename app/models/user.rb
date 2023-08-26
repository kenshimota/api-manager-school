class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  belongs_to :role
  belongs_to :person
  validates :password, presence: true, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-.]).{8,}/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
