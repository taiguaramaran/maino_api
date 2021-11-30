class CreateLaunches < ActiveRecord::Migration[6.0]
  def change
    create_table :launches do |t|
      t.string :idLaunch
      t.string :provider
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
