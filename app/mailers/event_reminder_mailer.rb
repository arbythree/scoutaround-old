require 'mail'

class EventReminderMailer < ApplicationMailer
  # this one goes to the youth him or herself
  def seven_day_prior_youth_reminder(event_registration)
    @event_registration = event_registration
    @recipient = @event_registration.user
    return if @recipient.anonymous_email?

    days_from_now = ((event_registration.event.starts_at - Time.now) / 1.day).to_i

    address = Mail::Address.new @recipient.email
    address.display_name = @recipient.full_name.dup

    mail(
      to: address.format,
      subject: I18n.t(
        @event_registration.complete? ? 'email.subjects.event_reminder_registrant_complete' : 'email.subjects.event_reminder_registrant_incomplete',
        days: days_from_now,
        event_name: event_registration.event.name
      )
    )
  end

  # this one goes to guardians who are *not* attending an event
  def seven_day_prior_guardian_reminder(event, guardian)
    @guardian = guardian
    @event = event
    @registrations = []

    # If one or more of this family's registrations are incomplete, we'll
    # raise a flag. We'll use that flag to determine the subject line
    # (fire drill vs. all is well)
    @some_incomplete = false

    days_from_now = ((event.starts_at - Time.now) / 1.day).to_i

    # which of this guardian's guardees are going to this event?
    # TODO: optimize this
    @guardian.guardees.each do |guardee|
      if @event.registered_for?(user: guardee)
        registration = @event.event_registrations.find_by(user: guardee)
        @registrations << registration
        @some_incomplete = true if registration.incomplete? # raise that flag
      end
    end

    # generate a pretty email address like "Abraham Lincoln <abe@whitehouse.gov>"
    address = Mail::Address.new @guardian.email
    address.display_name = @guardian.full_name.dup

    mail(
      to: address.format,
      subject: I18n.t(
        @some_incomplete ? 'email.subjects.event_reminder_guardian_incomplete' : 'email.subjects.event_reminder_guardian_complete',
        days: days_from_now,
        event_name: @event.name
      )
    )
  end

  # this one goes to adults who *are* attending
  def seven_day_prior_adult_reminder(event_registration)
    @event_registration = event_registration
    @recipient = @event_registration.user
    return if @recipient.anonymous_email?

    days_from_now = ((event_registration.event.starts_at - Time.now) / 1.day).to_i

    mail(
      to: @recipient.email,
      subject: I18n.t(
        @event_registration.complete? ? 'email.subjects.event_reminder_complete' : 'email.subjects.event_reminder_incomplete',
        days: days_from_now,
        event_name: event_registration.event.name
      )
    )
  end
end
