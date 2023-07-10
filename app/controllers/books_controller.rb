class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @tag_list = @book.tags.pluck(:tag).join(',')

  end

  def index
  #ソート機能
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
    	@books = Book.old
    elsif params[:star_count]
    	@books = Book.star_count
    elsif params[:iine_count]
      #過去一週間でいいねの合計カウントが多い順に投稿を表示する
      to = Time.current.at_end_of_day
      from = (to - 6.day).at_beginning_of_day
      @books = Book.includes(:favorites).sort_by {
        |book|-book.favorites.where(created_at: from...to).count }
    else
    	@books = Book.all.order(params[:sort])
    end
    @book = Book.new
  end

  def create  #ここは模範解答例と同じ
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag].split(',')
    if @book.save
      @book.save_book_tags(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @tag_list = @book.tags.pluck(:tag).join(',')
  end

  def update
    @book = Book.find(params[:id])
    tag_list=params[:book][:tag].split(',')
    if @book.update(book_params)
      @book.save_book_tags(tag_list)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search_tag
      #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
      #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
      #検索されたタグに紐づく投稿を表示
    @books= @tag.books

  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to  "/books"
    end
  end

end
