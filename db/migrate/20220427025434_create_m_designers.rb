class CreateMDesigners < ActiveRecord::Migration[5.2]
  def change
    create_table :m_designers, id: false do |t|
      t.references :designer, null: false, primary_key: true
      t.string :name
      t.string :name_jp
      t.timestamps
    end
  end
end
