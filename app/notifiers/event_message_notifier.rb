#
# a Notifier for event messages
#
class EventMessageNotifier < ApplicationNotifier
  def self.send_message_notifications(message)
    self.notify_all_registrants(message)        if message.pingees == 'all_registrants'
    self.notify_incomplete_registrants(message) if message.pingees == 'incomplete_registrants'
    self.notify_complete_registrants(message)   if message.pingees == 'complete_registrants'
  end

  private

  def self.notify_all_registrants(message)
    event = message.messagable
    event.event_registrations.each do |registration|
      self.notify_registrant(message, registration)
    end
  end

  def self.notify_incomplete_registrants(message)
    event = message.messagable
    event.event_registrations.each do |registration|
      next unless registration.incomplete?
      self.notify_registrant(message, registration)
    end
  end

  def self.notify_complete_registrants(message)
    event = message.messagable
    event.event_registrations.each do |registration|
      next unless registration.complete?
      self.notify_registrant(message, registration)
    end
  end

  def self.notify_registrant(message, registration)
    EventMessageMailer.message_notification_email(message, registration).deliver_later
  end
end
