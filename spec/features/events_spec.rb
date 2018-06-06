require 'rails_helper'

RSpec.feature "Event requirements features", :type => :feature do
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

  it 'shows all events' do
    expect(page).to have_current_path(unit_events_path(@unit))
  end

  it 'makes a new event' do
    click_on I18n.t('events.add')
    event_name = 'new event xyz'
    fill_in 'event_name', with: event_name
    click_on I18n.t('events.add')
    expect(page).to have_current_path(unit_events_path(@unit))
    expect(page).to have_content(I18n.t('events.confirm'))
    expect(page).to have_content(event_name)
  end

  it 'updates an event' do
    visit event_path(@event)
    click_on I18n.t('events.edit')
    new_location = 'new location xyz'
    fill_in 'event_location', with: new_location
    click_on I18n.t('update')
    expect(page).to have_current_path(event_path(@event))
    expect(page).to have_content(new_location)
  end
end
