#
# a Requirement is a kind of Achievable, but has a parent_achievable (e.g. a Rank)
#
class Requirement < Achievable
  belongs_to :achievable, class_name: 'Achievable', foreign_key: 'parent_achievable_id'

  def completed_for?(user: nil)
    Achievement.exists?(user: user, achievable: self)
  end
end
