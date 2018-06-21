#
# for "complete one of the following"-style requirements
#
class MultipleChoiceRequirement < Requirement
  def completed_by?(user: nil)
    completion_count = 0

    requirements.each do |requirement|
      completion_count += 1 if requirement.completed_by?(user: user)
    end

    completion_count >= self.param
  end

  #
  # even though not a true leaf, we return true because otherwise
  # progress numbers will be distorted
  #
  def leaf?
    true
  end
end
