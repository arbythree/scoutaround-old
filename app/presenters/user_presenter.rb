class UserPresenter < BasePresenter
  presents :user

  def display_name
    "#{user.full_name}"
  end

  def type
    t("users.#{user.type.downcase}")
  end

  def rank
    user.rank
  end
end
