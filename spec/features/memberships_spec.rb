require 'rails_helper'

RSpec.feature "Membership features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
    first(:link, I18n.t('members.roster')).click
  end

  it 'is on the Roster page' do
    expect(page).to have_current_path(unit_memberships_path(@unit))
  end

  it 'goes to the New Member page when New Member is clicked' do
    click_on I18n.t('members.add')
    expect(page).to have_current_path(new_unit_membership_path(@unit))
  end

  it 'adds a new Youth' do
    click_on I18n.t('members.add')
    choose I18n.t('users.youth')
    fill_in 'membership_user_attributes_first_name', with: 'Mortimer'
    fill_in 'membership_user_attributes_last_name', with: 'Snerd'
    click_on I18n.t('memberships.add_new')
    expect(page).to have_content('Mortimer')
    expect(page).to have_content('Snerd')
  end
end
