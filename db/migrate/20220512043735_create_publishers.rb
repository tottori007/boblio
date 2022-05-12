class CreatePublishers < ActiveRecord::Migration[5.2]
  def change
    create_table :publishers do |t|
      t.integer :game_id
      t.integer :publisher_id
      t.timestamps
    end
  end
end
