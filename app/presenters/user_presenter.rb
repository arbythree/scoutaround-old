class UserPresenter < BasePresenter
  presents :user

  def display_name
    "#{user.full_name}"
  end

  def type
    t("users.#{user.type.downcase}")
  end

  def rank
    user&.rank&.name
  end

  def self.display_email_for(user: nil)
    user.anonymous_email? ? '' : user.email
  end
end
