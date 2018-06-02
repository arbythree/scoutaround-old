require 'rails_helper'

RSpec.feature "Advancement features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    @membership = Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
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
end
