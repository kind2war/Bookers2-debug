class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :book_tags do |t|
      t.string "tag"

      t.timestamps
    end
      add_index :book_tags,  unique:true
  end
end
