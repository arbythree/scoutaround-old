require "rails_helper"

RSpec.describe EventSubmissionMailer, type: :mailer do
  describe 'document_receipt_registrant_email' do
    it 'creates a registrant email' do
      event_registration = FactoryBot.create(:event_registration)
      event_requirement  = FactoryBot.create(:event_requirement)

      email = EventSubmissionMailer.document_receipt_registrant_email(
        recipient:          event_registration.user,
        event_requirement:  event_requirement,
        event_registration: event_registration
      )
    end

    it 'creates a guardian email' do
      event_registration = FactoryBot.create(:event_registration)
      event_requirement  = FactoryBot.create(:event_requirement)

      email = EventSubmissionMailer.document_receipt_guardian_email(
        recipient:          event_registration.user,
        event_requirement:  event_requirement,
        event_registration: event_registration
      )
    end
  end
end
