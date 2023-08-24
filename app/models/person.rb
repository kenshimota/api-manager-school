class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :identity_document, presence: true, uniqueness: true
  validates :phone_code, presence: true, length: { minimum: 1, maximum: 3 }
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 12 }
end
