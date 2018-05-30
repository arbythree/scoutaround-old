#
# (e.g. Second Class (the Achievable) requires having been a Tenderfoot (the precursor)
# for at least 3 months (the param)
#
class TenureRequirement < Requirement
  belongs_to :precursor, class_name: 'Achievable'

  def name
    "Be active in your troop for at least #{ param / 1.month } months as a #{ precursor.name } Scout."
  end
end
