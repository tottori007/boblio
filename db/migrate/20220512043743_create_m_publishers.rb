class CreateMPublishers < ActiveRecord::Migration[5.2]
  def change
    create_table :m_publishers, id: false do |t|
      t.references :publisher, null: false, primary_key: true
      t.string :name
      t.string :country
      t.string :official_url
      t.timestamps
    end
  end
end
