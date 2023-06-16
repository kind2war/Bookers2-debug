class ChangeDatatypeBookIdOfBookComments < ActiveRecord::Migration[6.1]
  def change
    change_column :book_comments, :book_id, :integer
  end
end
