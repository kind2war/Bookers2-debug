class Tag < ApplicationRecord
  has_many :post_book_tags, dependent: :destroy
  has_many :books, through: :post_book_tags
  validates :tag, presence:false, length:{maximum:20}

end
