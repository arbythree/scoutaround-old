class EventSubmissionNotifier < ApplicationNotifier
  def send_document_receipt_notifications(event_registration, event_requirement)
    registrant = event_registration.user

    EventSubmissionMailer.document_receipt.with(
      recipient:          registrant,
      event_registration: event_registration,
      event_requirement:  event_requirement
    ).deliver_later

    registrant.user.guardians.each do |guardian|
      EventSubmissionMailer.document_receipt.with(
        recipient: guardian,
        event_registration: event_registration,
        event_requirement: event_requirement
      ).deliver_later
    end
  end
end
