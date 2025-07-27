class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, index: true, null: false
      t.string :author, index: true, null: false
      t.string :genre, index: true, null: false
      t.string :isbn, null: false, index: { unique: true }
      t.integer :total_copies, null: false

      t.timestamps
    end
  end
end
