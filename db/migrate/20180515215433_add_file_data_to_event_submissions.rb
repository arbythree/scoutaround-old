class AddFileDataToEventSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :event_submissions, :file_data, :text
  end
end
