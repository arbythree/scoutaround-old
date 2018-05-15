require 'rails_helper'

RSpec.describe EventRequirement, type: :model do
  it 'has a valid DocumentEventRequirement factory' do
    expect(FactoryBot.create(:document_event_requirement)).to be_valid
  end

  it 'has a valid PaymentEventRequirement factory' do
    expect(FactoryBot.create(:payment_event_requirement)).to be_valid
  end

  it 'completed_for is truthy when a submission is present' do
    submission = FactoryBot.create(:event_submission)
    expect(submission.event_requirement.completed_for?(submission.event_registration.person)).to be_truthy
  end

  it 'completed_for is falsey when a submission is absent' do
  end
end
