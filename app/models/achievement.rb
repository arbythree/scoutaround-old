class Achievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievable
  validates_uniqueness_of :user, scope: :achievable
  validate :achievable_is_concrete

  #
  # don't allow achievements for "virtual" requirements
  # whose completeness is computed, not directly earned
  #
  def achievable_is_concrete
    errors.add(:achievable, 'Must be concrete') unless self.achievable.concrete?
  end
end
