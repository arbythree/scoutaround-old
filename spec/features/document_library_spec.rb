require 'rails_helper'

RSpec.feature "Document Library features", type: :feature do
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

  it 'visits the document library' do
    visit unit_document_library_items_path(@unit)
    expect(page).to have_current_path(unit_document_library_items_path(@unit))
  end
end
