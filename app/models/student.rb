class Student < ApplicationRecord
  paginates_per 25

  belongs_to :person

  validates :person_id, presence: :true, uniqueness: true
  validates :birthday, presence: :true, timeliness: { before: lambda { Date.current - ((365 * 10) - 7) }, type: :date }
end
