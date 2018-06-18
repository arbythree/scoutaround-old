#
# send notifications to senders and recipients of MagicLinks
# to make them aware of impending or recent expirations, etc.
#
namespace :scoutaround do
  namespace :magic_links do
    ######
    desc 'Notify senders when their magic links aren\'t opened'
    task send_unredeemed_notifications: :environment do

      key = 'unredeemed_magic_link_notifications.last_run_at'

      # establish the time boundaries
      last_run = ApplicationDatum.get(key) || 24.hours.ago.to_s
      now = Time.now.utc

      puts "Last run at #{ last_run }"

      magic_links = MagicLink.unredeemed.where('expires_at < ? AND expires_at > ?', now, Time.parse(last_run))
      magic_links.each do |magic_link|
        MagicLinkMailer.sender_expiration_email(magic_link).deliver_now
      end

      # store high water mark
      ApplicationDatum.set(key, now.to_s)

      puts "Notified for #{ magic_links.count } magic links"
      puts "Set high water mark to #{ ApplicationDatum.get(key) }"
    end

    #####
    desc 'Notify recipients when their magic links are about to expire'
    task send_impending_expiration_warnings: :environment do

      # find unopened links that are going to expire
      magic_links = MagicLink.unredeemed.where('expires_at < ?', 24.hours.from_now)
      magic_links.each do |magic_link|
        MagicLinkMailer.impending_expiration_warning(magic_link).deliver_now
      end
    end
  end
end
