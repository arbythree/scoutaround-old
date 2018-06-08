class EventSubmissionMailer < ApplicationMailer
  def document_receipt_email
    @user = params[:user]
    @event_registration = params[:event_registration]
    @event_requirement = params[:event_requirement]

    return if @user.anonymous_email?

    mail(
      to: @user.email,
      event_registration: @event_registration,
      event_requirement: @event_requirement
    )
  end
end
