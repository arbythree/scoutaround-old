# a form of Achievable that requires time spent since a precursor
# (typically another rank)

class Tenure < Achievable
  belongs_to :precursor, class_name: 'Achievable'
end
