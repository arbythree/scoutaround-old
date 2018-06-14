class EventSubmissionNotifier < ApplicationNotifier
  #
  # when an event document is received, let the registrant (and guardians) know
  #
  def self.send_document_receipt_notifications(submission)
    event_registration = submission.event_registration
    event_requirement  = submission.event_requirement
    registrant         = event_registration.user

    # first, the registrant
    EventSubmissionMailer.document_receipt_registrant_email(
      registrant,
      event_registration,
      event_requirement
    ).deliver_later

    # then, guardians
    registrant.guardians.each do |guardian|
      EventSubmissionMailer.document_receipt_guardian_email(
        guardian,
        event_registration,
        event_requirement
      ).deliver_later
    end
  end

  #
  # send to payer when a payment is received
  #
  def self.send_payment_receipt_notification(submission)
    event_registration = submission.event_registration
    event_requirement  = submission.event_requirement
    registrant         = event_registration.user

    EventSubmissionMailer.payment_receipt_email(
      registrant,
      event_registration,
      event_requirement
    ).deliver_later
  end
end
