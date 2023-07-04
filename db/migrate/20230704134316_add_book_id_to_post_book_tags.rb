class AddBookIdToPostBookTags < ActiveRecord::Migration[6.1]
  def change
    add_column :post_book_tags, :book_id, :integer
  end
end
