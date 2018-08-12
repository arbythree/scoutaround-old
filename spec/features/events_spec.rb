require 'rails_helper'

RSpec.feature "Event requirements features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
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
    # expect(page).to have_content(I18n.t('events.confirm'))
    # expect(page).to have_content(event_name)
  end

  it 'updates an event' do
    visit unit_event_path(@unit, @event)
    click_on I18n.t('events.edit')
    new_location = 'new location xyz'
    fill_in 'event_location', with: new_location
    click_on I18n.t('update')
    expect(page).to have_current_path(unit_event_path(@unit, @event))
    # expect(page).to have_content(new_location)
  end
end
