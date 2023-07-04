class AddTagIdToPostBookTags < ActiveRecord::Migration[6.1]
  def change
    add_column :post_book_tags, :tag_id, :integer
  end
end
