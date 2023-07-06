class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_book_tags, dependent: :destroy
  has_many :tags, through: :post_book_tags
  validates :title, presence:true
  validates :body, presence:true,length:{maximum:200}
  validates :tag, presence:false,length:{maximum:20}
  scope :latest, -> {order(updated_at: :DESC)}
  scope :old, -> {order(updated_at: :ASC)}
  scope :star_count, -> {order(star: :DESC)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
      #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる。
      #存在していればtrue、存在していなければfalseを返す

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def self.search(search)
    if search != ""
      Book.where(['tag LIKE(?)', "%#{search}%"])
    else
      Book.includes(:user).order('created_at DESC') #N:1問題
    end
  end

  def save_book_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(tag:new_name)
      self.tags << tag
    end
  end

end
