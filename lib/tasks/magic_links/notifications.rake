namespace :scoutaround do
  namespace :magic_links do
    desc 'Notify senders when their magic links aren\'t opened'
    task send_unredeemed_notifications: :environment do

      key = 'unredeemed_magic_link_notifications.last_run_at'

      # establish the time boundaries
      last_run = ApplicationDatum.get(key) || 24.hours.ago.to_s
      now = Time.now.utc

      puts "Last run at #{ last_run }"
      
      magic_links = MagicLink.unredeemed.where('expires_at < ? AND expires_at > ?', now, Time.parse(last_run))
      magic_links.each do |magic_link|
        MagicLinkMailer.sender_expiration_email(magic_link).deliver_later
      end

      # store high water mark
      ApplicationDatum.set(key, now.to_s)

      puts "Notified for #{ magic_links.count } magic links"
      puts "Set high water mark to #{ ApplicationDatum.get(key) }"
    end
  end
end
