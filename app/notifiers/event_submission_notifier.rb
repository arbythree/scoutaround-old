class EventSubmissionNotifier < ApplicationNotifier
  before_action :find_registration
  before_action :find_requirement
  before_action :find_registrant

  def document_receipt
    EventSubmissionMailer.document_receipt.with(
      recipient: @registrant,
      event_registration: @event_registration,
      event_requirement: @event_requirement
    ).deliver_later
    registrant.guardians.each do |guardian|
      EventSubmissionMailer.document_receipt.with(
        recipient: guardian,
        event_registration: @event_registration,
        event_requirement: @event_requirement
      ).deliver_later
    end
  end

  private

  def find_receipient
    @registrant = @event_registration.user
  end

  def find_requirement
    @event_requirement = params[:event_requirement]
  end

  def find_registration
    @event_registration = params[:event_registration]
  end
end
