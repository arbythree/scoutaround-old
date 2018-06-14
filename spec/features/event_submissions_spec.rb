require 'rails_helper'

RSpec.feature "Event submissions features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    @event = FactoryBot.create(:event, unit: @unit)
    @requirement = @event.event_requirements.create(description: 'required document', type: 'DocumentEventRequirement')
    @registration = @event.event_registrations.create(user: @user)
    Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on I18n.t('auth.sign_in')
  end

  it 'uploads a submission' do
    # puts new_event_requirement_event_submission_path(@requirement, registration: @registration.id)
    visit new_event_requirement_event_submission_path(@requirement, registration: @registration.id)
    save_and_open_page
    select @user.full_name,          from: 'event_submission_event_registration_id'
    select @requirement.description, from: 'event_submission_event_requirement_id'
    attach_file 'event_submission_attachment', File.expand_path('../support/test_attachment.pdf', __dir__)
    click_on I18n.t('submissions.upload')
    expect(page).to have_current_path(event_event_registrations_path(@event))
  end

  it 'visits the event submission page' do
    visit new_event_event_submission_path(@event)
    expect(page).to have_current_path(new_event_event_submission_path(@event))
  end
end
