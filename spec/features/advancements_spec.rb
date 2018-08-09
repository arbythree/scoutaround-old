require 'rails_helper'

RSpec.feature "Advancement features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    Rank.where(ordinal: 0, name: 'Scout').first_or_create
  end

  it 'works' do
    visit membership_achievements_path(@membership)
    expect(page).to have_current_path(membership_achievements_path(@membership))
  end

  it 'unit advancement page works when a youth doesn\'t have a rank' do
    rankless_youth = FactoryBot.create(:youth, rank: nil)
    Membership.create(user: rankless_youth, unit: @unit)
    visit unit_achievements_path(@unit)
    expect(page).to have_current_path(unit_achievements_path(@unit))
  end
end
