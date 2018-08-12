class UnitPositionPolicy < ApplicationPolicy
  def initialize(user, unit_position)
    @user = user
    @unit = unit_position.unit
    @membership = @unit.membership_for(user: @user)
    @unit_position = unit_position
  end

  def index?
    @membership.role == 'admin'
  end

  def create?
    @membership.role == 'admin'
  end

  def update?
    unit = @unit_position.unit
    user = @membership # hack alert
    membership = unit.memberships.find_by(user: user)
    membership.role == 'admin'
  end

  def destroy?
    unit = @unit_position.unit
    user = @membership # hack alert
    membership = unit.memberships.find_by(user: user)
    membership.role == 'admin'
  end
end
