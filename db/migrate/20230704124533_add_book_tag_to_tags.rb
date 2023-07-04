class AddBookTagToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :book_id, :integer
  end
end
