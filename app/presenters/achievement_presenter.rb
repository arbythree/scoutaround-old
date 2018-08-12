class AchievementPresenter < BasePresenter
  def self.type(achievement)
    achievement.type.underscore.humanize.titleize
  end
end
