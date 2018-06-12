class EventSubmissionMailer < ApplicationMailer
  def document_receipt_registrant_email(recipient, event_registration, event_requirement)
    return if recipient.anonymous_email?
    return if recipient == @current_user # no sense sending to yourself

    @event_registration = event_registration
    @event_requirement  = event_requirement

    mail(
      to: recipient.email,
      subject: I18n.t(
        'email.subjects.document_receipt_registrant',
        document_name: @event_requirement.description
      )
    )
  end

  def document_receipt_guardian_email(recipient, event_registration, event_requirement)
    return if recipient.anonymous_email?

    @event_registration = event_registration
    @event_requirement  = event_requirement

    mail(
      to: recipient.email,
      subject: I18n.t(
        'email.subjects.document_receipt_guardian',
        person: @event_registration.user.first_name,
        document_name: @event_requirement.description
      )
    )
  end
end
