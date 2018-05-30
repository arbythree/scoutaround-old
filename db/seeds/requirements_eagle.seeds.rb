after :ranks do
  eagle = Rank.find_by(name: 'Eagle')

  TenureRequirement.where(program_code: 'bsa', achievable: eagle, param: 6.months, precursor: Rank.find_by(name: 'Life')).first_or_create

  AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Personal Management').becomes(Achievable)).first_or_create
  AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Citizenship in the Community').becomes(Achievable)).first_or_create
  AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Citizenship in the Nation').becomes(Achievable)).first_or_create
  AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Citizenship in the World').becomes(Achievable)).first_or_create

  # earn one of the following two badges:
  green_merit_badge_option = MultipleChoiceRequirement.create(achievable: eagle, param: 1)
  AchievementRequirement.create(program_code: 'bsa', achievable: green_merit_badge_option, requirable: MeritBadge.find_by(name: 'Sustainability').becomes(Achievable))
  AchievementRequirement.create(program_code: 'bsa', achievable: green_merit_badge_option, requirable: MeritBadge.find_by(name: 'Environmental Science').becomes(Achievable))

  # earn one of the following two badges:
  preparedness_merit_badge_option = MultipleChoiceRequirement.create(achievable: eagle, param: 1)
  AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Emergency Preparedness').becomes(Achievable))
  AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Lifesaving').becomes(Achievable))

  # earn one of the following three badges:
  athletic_merit_badge_option = MultipleChoiceRequirement.create(achievable: eagle, param: 1)
  AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Swimming').becomes(Achievable))
  AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Cycling').becomes(Achievable))
  AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Personal Fitness').becomes(Achievable))
end
