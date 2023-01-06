class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :chat_room, foreign_key: true
      t.integer :from_id
      t.text :body
      t.timestamps
    end
  end
end
