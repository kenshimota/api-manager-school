class Section < ApplicationRecord
  before_create do
    self.letter = self.letter.upcase
  end

  validates :letter, presence: true, length: { maximum: 1, minimum: 1 }, uniqueness: { case_sensitive: false }
end
