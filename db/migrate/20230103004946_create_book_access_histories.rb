class CreateBookAccessHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :book_access_histories do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
