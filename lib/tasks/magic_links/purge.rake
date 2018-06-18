#
# even though MagicLinks expire within a matter of days, we let them live
# (in their expired state) for a longer period of time so that, when clicked,
# the end user still sees an "expired" message as opposed to a 404. On the
# other hand, we don't need them to lie around forever. This task, then,
# takes care of the deferred cleanup.
# Purge age can be set in /config/settings.yml
#
namespace :scoutaround do
  namespace :magic_links do
    desc 'Remove old magic links'
    task purge: :environment do
      magic_links = MagicLink.where('expires_at > ?', (Settings.magic_links.purge_age || 30).days.ago)
      count = magic_links.count
      magic_links.destroy_all
      puts "Purged #{count} magic links"
    end
  end
end
