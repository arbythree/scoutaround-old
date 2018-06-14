namespace :scoutaround do
  namespace :events do
    desc 'Send reminders to youth registrants'
    task youth_reminders: :environment do

      # iterate over all future events in the system
      # TODO: query for specific date and where registrants are youths
      Event.future.each do |event|
        days_from_now = ((event.starts_at - Time.now) / 1.day).to_i
        puts "#{event.unit.type} #{event.unit.number} - #{event.name} (#{days_from_now} days from now)"

        next unless days_from_now == 7 || ENV['time_offset'] == '7.days'

        event.event_registrations.each do |registration|
          puts "#{registration.user.short_name} (#{registration.complete? ? 'complete' : 'incomplete'})"
          EventReminderMailer.seven_day_prior_youth_reminder(registration).deliver_later if registration.user.type == 'Youth'
        end # iterative over registrations
      end # iterate over events

      puts 'Event reminders sent'
    end # taks

    desc 'Send reminders to unregistered guardians'
    task guardian_reminders: :environment do
      Event.future.each do |event|
        days_from_now = ((event.starts_at - Time.now) / 1.day).to_i
        puts "#{event.unit.type} #{event.unit.number} - #{event.name} (#{days_from_now} days from now)"

        next unless days_from_now == 7 || ENV['time_offset'] == '7.days'

        # TODO: refactor this...can be much more efficient
        unregistered_guardians = event.event_registrations.map { |reg| reg.user.guardians }
        unregistered_guardians.uniq! # prevent spam :)
        unregistered_guardians.flatten!
        unregistered_guardians.select! { |g| !event.registered_for?(user: g) } # remove those who are registered

        next if unregistered_guardians.count.zero?

        unregistered_guardians.each do |guardian|
          # the mailer will gather up all registered guardees and stuff their registration
          # status into a single email
          EventReminderMailer.seven_day_prior_guardian_reminder(event, guardian).deliver_later
        end
      end # iterate over events
    end

    desc 'Send reminders to registered adults'
    task adult_reminders: :environment do
    end
  end # namespace events
end # namespace scoutaround
