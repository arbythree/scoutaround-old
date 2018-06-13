require 'rails_helper'

RSpec.describe EventRequirement, type: :model do
  it 'has a valid DocumentEventRequirement factory' do
    expect(FactoryBot.create(:document_event_requirement)).to be_valid
  end

  it 'has a valid FeeEventRequirement factory' do
    expect(FactoryBot.create(:payment_event_requirement)).to be_valid
  end

  it 'completed_for is truthy when a submission is present' do
    event = FactoryBot.create(:event)
    registration = FactoryBot.create(:event_registration, event_id: event.id)
    requirement = FactoryBot.create(:event_requirement, event_id: event.id)
    submission = FactoryBot.create(:event_submission, event_registration_id: registration.id, event_requirement_id: requirement.id)
    expect(submission.event_requirement.completed_by?(user: submission.event_registration.user)).to be_truthy
  end

  describe 'validations' do
    it 'requires a positive adult price' do
      expect(FactoryBot.build(:payment_event_requirement, amount_adult: -1)).not_to be_valid
    end

    it 'requires a positive youth price' do
      expect(FactoryBot.build(:payment_event_requirement, amount_youth: -1)).not_to be_valid
    end
  end
end
