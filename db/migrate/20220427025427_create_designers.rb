class CreateDesigners < ActiveRecord::Migration[5.2]
  def change
    create_table :designers do |t|
      t.integer :game_id
      t.integer :designer_id
      t.timestamps
    end
  end
end
