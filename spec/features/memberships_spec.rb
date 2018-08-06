require 'rails_helper'

RSpec.feature "Membership features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    first(:link, I18n.t('members.roster')).click
  end

  it 'is on the Roster page' do
    expect(page).to have_current_path(unit_memberships_path(@unit))
  end

  it 'shows a membership' do
    visit membership_path(@membership)
    expect(page).to have_current_path(membership_path(@membership))
  end

  it 'adds a new Youth' do
    click_on I18n.t('memberships.add.youth')
    expect(page).to have_current_path(new_unit_membership_path(@unit, type: 'youth'))
    fill_in 'membership_user_attributes_first_name', with: 'Mortimer'
    fill_in 'membership_user_attributes_last_name', with: 'Snerd'
    click_on I18n.t('memberships.add_new')
  end

  it 'displays the membership page' do
    visit membership_path(@membership)
  end

  it 'displays the membership edit page' do
    visit edit_membership_path(@membership)
    expect(page).to have_current_path(edit_membership_path(@membership))
  end

  describe 'editing' do
    it 'has adult positions when editing an adult' do
      visit edit_membership_path(@membership)
      expect(page).to have_select('membership_unit_position_id', @membership.unit.unit_positions.map(&:name))
    end
  end
end
