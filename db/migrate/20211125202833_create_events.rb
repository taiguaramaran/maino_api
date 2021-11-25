class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :idEvent
      t.string :provider
      t.string :article_id

      t.timestamps
    end
  end
end
