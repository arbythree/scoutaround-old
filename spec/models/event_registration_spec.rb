require 'rails_helper'

RSpec.describe EventRegistration, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:event_registration)).to be_valid
  end

  it 'prevents duplicates' do
    registration = FactoryBot.create(:event_registration)
    expect(FactoryBot.build(:event_registration, event_id: registration.event_id, user_id: registration.user_id)).not_to be_valid
  end

  it 'prevents empty user' do
    registration = FactoryBot.build(:event_registration, user: nil)
    expect(registration).not_to be_valid
  end

  it 'prevents empty event' do
    registration = FactoryBot.build(:event_registration, event: nil)
    expect(registration).not_to be_valid
  end

  it 'event has user as a registrant' do
    registration = FactoryBot.create(:event_registration)
    event = registration.event
    user = registration.user
    expect(event.registrants).to include(user)
  end

  describe 'completeness' do
    before do
      @registration = FactoryBot.create(:event_registration)
      @requirement = @registration.event.event_requirements.create(description: 'necessary document')
    end

    it 'is initially incomplete' do
      expect(@registration.completed?).to be_falsey
    end

    it 'is completed when all requirements have submissions' do
      @registration.event.event_requirements.each do |requirement|
        submission = FactoryBot.create(:event_submission, event_registration: @registration, event_requirement: requirement)
      end
      @registration.reload
      expect(@registration.completed?).to be_truthy
    end
  end
end
