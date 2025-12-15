class CreateEpisodes < ActiveRecord::Migration[8.1]
  def change
    create_table :episodes do |t|
      t.references :season, null: false, foreign_key: true
      t.integer :number
      t.string :title
      t.date :aired_date
      t.text :description

      t.timestamps
    end
  end
end
