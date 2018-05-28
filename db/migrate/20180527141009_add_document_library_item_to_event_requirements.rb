class AddDocumentLibraryItemToEventRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :event_requirements, :document_library_item_id, :integer
  end
end
