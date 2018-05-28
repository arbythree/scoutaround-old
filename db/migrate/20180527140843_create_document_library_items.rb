class CreateDocumentLibraryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :document_library_items do |t|
      t.string :name
      t.integer :unit_id

      t.timestamps
    end
  end
end
