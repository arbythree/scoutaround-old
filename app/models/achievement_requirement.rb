#
# a Requirement that relies on another Achievable having been earned
#
class AchievementRequirement < Requirement
  belongs_to :requirable, class_name: 'Achievable'
end
