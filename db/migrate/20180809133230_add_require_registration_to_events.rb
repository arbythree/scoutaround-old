class AddRequireRegistrationToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :require_registration, :boolean, default: false
  end
end
