class UnitPolicy < ApplicationPolicy
  def initialize(user, unit)
    @user = user
    @unit = unit
  end

  def show?
    unit.members.include?(user)
  end

  def edit?
    return false
    unit.role_for(user: user) == 'admin'
  end

  def update?
    unit.role_for(user: user) == 'admin'
  end
end
