class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to request.referer
      #まずbookを特定する。
      #ログイン中のﾕｰｻﾞｰとしてbook.idに紐づける形でfavoritesを新たに１つだけ作る。
      #保存する
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end

end
