class AddUnitIdToMagicLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_links, :unit_id, :integer
  end
end
