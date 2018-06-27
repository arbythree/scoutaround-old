class AddPostNominalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :post_nominal, :string
  end
end
