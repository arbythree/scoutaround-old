#
# for "complete one of the following"-style requirements
#
class MultipleChoiceRequirement < Requirement
  def completed_for?(user: nil)
    completion_count = 0

    requirements.each do |requirement|
      completion_count += 1 if requirement.completed_for?(user: user)
    end

    completion_count >= self.param
  end
end
