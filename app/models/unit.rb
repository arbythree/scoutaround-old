class Unit < ApplicationRecord
  has_many :events
  has_many :event_registrations, through: :events
  has_many :memberships
  has_many :members, through: :memberships, source: 'user'
  has_many :document_library_items
  has_many :achievements, through: :users
  has_many :magic_links
  belongs_to :primary_wiki_article, class_name: 'WikiArticle', optional: true
  validates_presence_of :number, :city, :state
  validates_uniqueness_of :number, scope: [:city, :state]

  def role_for(user: nil)
    memberships.where(user: user)&.first&.role
  end

  def ranks
    Rank.where(program_code: self.program_code).order(:ordinal)
  end

  def self.types
    [
      { id: 'Troop', name: 'Scout Troop',    program_code: 'bsa' },
      { id: 'Pack',  name: 'Cub Pack',       program_code: 'cubs' },
      { id: 'Crew',  name: 'Venturing Crew', program_code: 'venturing'},
      { id: 'Post',  name: 'Explorer Post',  program_code: 'exploring'}
    ]
  end

  def accepts_payments?
    self.stripe_user_id.present?
  end
end
