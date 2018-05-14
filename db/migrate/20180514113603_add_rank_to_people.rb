class AddRankToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :rank, :string
  end
end
