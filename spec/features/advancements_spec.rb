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
  end

  it 'works' do
    visit unit_membership_achievements_path(@unit, @membership)
    expect(page).to have_current_path(unit_membership_achievements_path(@unit, @membership))
  end
end
