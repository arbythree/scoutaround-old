require 'rails_helper'

RSpec.feature "Roster page", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    Membership.create(user: @user, unit: @unit)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
    save_and_open_page
    first(:link, I18n.t('members.roster')).click
  end

  it 'is on the Roster page' do
    expect(page).to have_current_path(unit_memberships_path(@unit))
  end

  it 'goes to the New Member page when New Member is clicked' do
    click_on I18n.t('members.add')
    expect(page).to have_current_path(new_unit_membership_path(@unit))
  end
end
