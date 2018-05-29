class Requirement < Achievable
  belongs_to :achievable
  belongs_to :required, class_name: 'Achievement'

  # override this
  def completed_by?(user: nil)
    return false
  end
end
