class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.integer :image_id
      t.string :name
      t.text :introduction
      t.timestamps
    end
  end
end
