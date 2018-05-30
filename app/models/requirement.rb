#
# a Requirement is a kind of Achievable, but has a parent_achievable (e.g. a Rank)
#
class Requirement < Achievable
  belongs_to :achievable, class_name: 'Achievable', foreign_key: 'parent_achievable_id'
end
