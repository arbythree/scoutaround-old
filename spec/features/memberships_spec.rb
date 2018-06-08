require 'rails_helper'

RSpec.feature "Membership features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    @membership = Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on I18n.t('auth.sign_in')
    first(:link, I18n.t('members.roster')).click
  end

  it 'is on the Roster page' do
    expect(page).to have_current_path(unit_memberships_path(@unit))
  end

  it 'shows a membership' do
    visit membership_path(@membership)
    expect(page).to have_current_path(membership_path(@membership))
    expect(page).to have_content(@user.full_name)
  end

  it 'adds a new Youth' do
    click_on I18n.t('memberships.add.youth')
    expect(page).to have_current_path(new_unit_membership_path(@unit, type: 'youth'))
    fill_in 'membership_user_attributes_first_name', with: 'Mortimer'
    fill_in 'membership_user_attributes_last_name', with: 'Snerd'
    # select I18n.t('ranks.life'), from: 'Rank'

    # save it
    click_on I18n.t('memberships.add_new')

    # look for correct data on resulting page
    expect(page).to have_content('Mortimer')
    expect(page).to have_content('Snerd')
    # expect(page).to have_content(I18n.t('ranks.life'))
  end

  it 'displays the membership page' do
    visit membership_path(@membership)
  end

  it 'displays the membership edit page' do
    visit edit_membership_path(@membership)
    expect(page).to have_current_path(edit_membership_path(@membership))
  end
end
