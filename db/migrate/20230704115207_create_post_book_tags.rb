class CreatePostBookTags < ActiveRecord::Migration[6.1]
  def change
  	create_table :post_book_tags do |t|
  	t.references :book_id, null: false, foreign_key: true
  	t.references :tag_id, null: false, foregin_key: true
  	t.timestamps
  	end

  	add_index :post_book_tags, [:book_id, :post_book_tag],unique: true
  end
end