#
# a Requirement is a kind of Achievable, but has a parent_achievable (e.g. a Rank)
#
class Requirement < Achievable
  belongs_to :parent_achievable, class_name 'Achievable'
  has_many :requirements
end
