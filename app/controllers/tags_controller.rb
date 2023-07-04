class TagsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @tag = Tag.find(params[:tag])
    Tag.new(book_tag_params).save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @tag = Tag.find(params[:tag])
    Tag.find(params[:tag]).destroy
  end

  private
    def book_tag_params
      params.require(:tag).permit(:tag)
    end
end
