require 'rails_helper'

RSpec.feature "Event requirements features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    @event = FactoryBot.create(:event, unit: @unit)
    @registration = @event.event_registrations.create(user: @user)
    Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
    visit unit_event_event_registrations_path(@unit, @event)
  end

  it 'shows all registrations' do
    expect(page).to have_current_path(unit_event_event_registrations_path(@unit, @event))
  end

  it 'shows a single registration' do
    visit unit_event_event_registration_path(@unit, @event, @registration)
    expect(page).to have_current_path(unit_event_event_registration_path(@unit, @event, @registration))
  end
end
