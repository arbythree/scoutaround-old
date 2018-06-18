require 'rails_helper'

RSpec.feature "Magic link", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    @event = FactoryBot.create(:event, unit: @unit)
    Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on I18n.t('auth.sign_in')
    visit unit_events_path(@unit)
  end

  it 'visits the unit magic links page' do
    visit unit_magic_links_path(@unit)
    expect(page).to have_current_path(unit_magic_links_path(@unit))
  end
end
