class CreateWikiArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :wiki_articles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end

    add_column :units, :primary_wiki_article_id, :integer
  end
end
