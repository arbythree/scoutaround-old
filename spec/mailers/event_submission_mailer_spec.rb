require "rails_helper"

RSpec.describe EventSubmissionMailer, type: :mailer do
  describe 'document_receipt_email' do
    it 'creates an email' do
      event_registration = FactoryBot.create(:event_registration)
      event_requirement  = FactoryBot.create(:event_requirement)

      email = EventSubmissionMailer.with(
        user: event_registration.user,
        event_requirement: event_requirement,
        event_registration: event_registration
      ).document_receipt_email
    end
  end
end
