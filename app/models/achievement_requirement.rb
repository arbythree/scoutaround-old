#
# a Requirement that relies on another Achievable having been earned
#
class AchievementRequirement < Requirement
  belongs_to :requireable, class_name: 'Achievement'
end
