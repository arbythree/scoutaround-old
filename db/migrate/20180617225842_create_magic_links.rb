class CreateMagicLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_links do |t|
      t.string   :magic_linkable_type
      t.string   :magic_linkable_id
      t.string   :recipient
      t.string   :token
      t.integer  :sender_id
      t.datetime :expires_at
      t.datetime :redeemed_at

      t.timestamps
    end
  end
end
