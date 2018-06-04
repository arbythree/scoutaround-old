class UserPolicy < ApplicationPolicy
  attr_reader :user, :target_user

  def initialize(user, target_user)
    @user = user
    @target_user = target_user
  end

  def show?
  end

  def edit?
    return true if @target_user == @user
    return true if @target_user.guardians.include?(@user)
    false
  end

  def update?
  end
end
