class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.integer :article_id
      t.string :title
      t.string :url
      t.string :imageUrl
      t.string :newsSite
      t.string :summary
      t.string :publishedAt
      t.string :updatedAt
      t.string :featured



      t.timestamps
    end
  end
end
