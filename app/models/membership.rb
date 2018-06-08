class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  belongs_to :unit_position, optional: true

  validates_uniqueness_of :user, scope: :unit
  enum role: {
    normal: 0,
    admin: 1,
  }
  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: :admin) }

  accepts_nested_attributes_for :user


  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << [
        'First',
        'Last',
        'Email',
        'Phone',
        'Type',
        'Position',
        'Rank'
      ]
      all.each do |membership|
        csv << [
          membership.user.last_name,
          membership.user.first_name,
          membership.user.email,
          membership.user.phone,
          membership.user.type,
          membership.unit_position&.name,
          membership.user.rank&.name
        ]
      end
    end
  end
end
