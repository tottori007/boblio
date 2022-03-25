class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games, id: false do |t|
      t.references :game, null: false, primary_key: true
      t.string :name_en, null: false, unique: true, index: true
      t.integer :release_year
      t.integer :player_min
      t.integer :player_max
      t.string :player_best
      t.integer :playing_time
      t.integer :playing_time_min
      t.integer :playing_time_max
      t.integer :age_min
      t.string :image_url
      t.string :thumbnail_url
      t.timestamps
    end
  end
end
