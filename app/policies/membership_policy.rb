class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :membership

  def initialize(user, membership)
    @user = user
    @target_user = target_user
  end

  def show?
    return is_self_or_admin?
  end

  def edit?
    return is_self_or_admin?
  end

  def update?
    return is_self_or_admin?
  end

  def is_self_or_admin?
    return true if @membership.user == @user
    return true if @membership.unit.role_for(user: @user) == 'admin'
    false
  end
end
