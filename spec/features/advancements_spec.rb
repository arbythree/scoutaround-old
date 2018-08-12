require 'rails_helper'

RSpec.feature "Advancement features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    Rank.where(ordinal: 0, name: 'Scout').first_or_create
  end

  it 'works' do
    visit unit_membership_achievements_path(@unit, @membership)
    expect(page).to have_current_path(unit_membership_achievements_path(@unit, @membership))
  end

  it 'unit advancement page works when a youth doesn\'t have a rank' do
    rankless_youth = FactoryBot.create(:youth, rank: nil)
    Membership.create(user: rankless_youth, unit: @unit)
    visit unit_achievements_path(@unit)
    expect(page).to have_current_path(unit_achievements_path(@unit))
  end

  describe 'achievements' do
    before do
      @merit_badge = MeritBadge.create(name: 'Snorking')
      @achievement = Achievement.create!(
        user_id: @user.id,
        achievable_id: @merit_badge.id
      )
    end

    it 'visits an achievement without an earned_at date' do
      visit(unit_membership_achievement_path(@unit, @membership, @achievement))
      expect(page).to have_current_path(unit_membership_achievement_path(@unit, @membership, @achievement))
    end

    it 'visits an achievement with an earned_at date' do
      @achievement.update!(earned_at: 2.weeks.ago)
      visit(unit_membership_achievement_path(@unit, @membership, @achievement))
      expect(page).to have_current_path(unit_membership_achievement_path(@unit, @membership, @achievement))

      save_and_open_page
      expect(page).to have_text(@achievement.earned_at.to_formatted_s(:scoutaround))
    end
  end
end
