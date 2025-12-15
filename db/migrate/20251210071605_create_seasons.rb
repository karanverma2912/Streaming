class CreateSeasons < ActiveRecord::Migration[8.1]
  def change
    create_table :seasons do |t|
      t.references :series, null: false, foreign_key: true
      t.integer :number
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
