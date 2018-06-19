class MagicLink < ApplicationRecord
  belongs_to :magic_linkable, polymorphic: true
  belongs_to :sender, class_name: 'User'
  belongs_to :unit
  before_create :generate_token
  before_create :set_expiration_date
  validates_uniqueness_of :token
  # validates_uniqueness_of :recipient, scope: [:magic_linkable_type, :magic_linkable_id], message: "You've already shared this with with that recipient"
  scope :unredeemed, -> { where('redeemed_at IS NULL') }

  def generate_token
    self.token = SecureRandom.hex(6)
  end

  def set_expiration_date
    # change the default lifespan in /config/settings.yml
    self.expires_at = Settings.magic_links.default_time_to_live.hours.from_now
  end

  def to_param
    self.token
  end

  def expired?
    self.expires_at < Time.now
  end

  def redeemed?
    self.redeemed_at.present?
  end
end
