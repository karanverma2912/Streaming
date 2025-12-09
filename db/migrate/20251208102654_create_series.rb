class CreateSeries < ActiveRecord::Migration[8.1]
  def change
    create_table :series do |t|
      t.string :title
      t.jsonb :titles
      t.text :synopsis
      t.text :description
      t.integer :genre
      t.integer :status
      t.integer :episodes_count
      t.integer :seasons_count
      t.integer :view_count
      t.integer :year
      t.integer :total_episodes
      t.date :release_date
      t.date :end_date

      t.timestamps
    end

    add_index :series, :status
    add_index :series, :genre
    add_index :series, :release_date
    add_index :series, :year
  end
end
