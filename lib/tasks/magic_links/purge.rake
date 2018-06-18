namespace :scoutaround do
  namespace :magic_links do
    desc 'Remove old magic links'
    task purge: :environment do
      magic_links = MagicLink.where('expires_at > ?', Settings.magic_links.purge_age.days.ago)
      count = magic_links.count
      magic_links.destroy_all
      puts "Purged #{count} magic links"
    end
  end
end
