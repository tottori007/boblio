class CreateGameOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :game_options, id: false do |t|
      t.references :game, null: false
      t.string :name_jp
      t.integer :expansion
      t.integer :play_limit
      t.text :description_en
      t.text :description_jp
      t.timestamps
    end
    add_foreign_key :game_options, :games, column: :game_id, primary_key: :game_id
  end
end