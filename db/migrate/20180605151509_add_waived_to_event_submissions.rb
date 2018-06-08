class AddWaivedToEventSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :event_submissions, :waived, :boolean, default: false
  end
end
