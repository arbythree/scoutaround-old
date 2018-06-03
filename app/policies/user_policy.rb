class UserPolicy < ApplicationPolicy
  attr_reader :user, :target_user

  def initialize(user, target_user)
    @user = user
    @target_user = target_user
  end

  def show?
  end

  def edit?
  end

  def update?
  end
end
