class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, presence:true
  validates :body, presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
      #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる。
      #存在していればtrue、存在していなければfalseを返す

end
