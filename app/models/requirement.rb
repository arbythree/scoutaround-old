#
# a Requirement is a kind of Achievable, but has a parent_achievable (e.g. a Rank)
#
class Requirement < Achievable
  belongs_to :achievable, class_name: 'Achievable', foreign_key: 'parent_achievable_id'

  def completed_by?(user: nil)
    return Achievement.exists?(user: user, achievable: self) if self.leaf?

    self.requirements.each do |requirement|
      return false unless requirement.completed_by?(user: user)
    end

    return true
  end
end
