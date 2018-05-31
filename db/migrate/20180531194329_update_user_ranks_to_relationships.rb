class UpdateUserRanksToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rank_id, :integer

    User.all.each do |user|
      target_rank = Rank.find_by(name: user.rank)
      if target_rank.present?
        user.rank_id = target_rank.id
        user.save
      end
    end

    remove_column :users, :rank
  end
end
