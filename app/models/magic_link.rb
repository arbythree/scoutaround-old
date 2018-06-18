class MagicLink < ApplicationRecord
  belongs_to :magic_linkable, polymorphic: true
  belongs_to :sender, class_name: 'User'
  before_create :generate_token
  before_create :set_expiration_date
  validates_uniqueness_of :token

  def generate_token
    self.token = SecureRandom.hex(6)
  end

  def set_expiration_date
    self.expires_at = 72.hours.from_now
  end

  def to_param
    self.token
  end
end
