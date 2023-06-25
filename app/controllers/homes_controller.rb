class HomesController < ApplicationController
  def top
    @book = Book.new
  end

  def about
    @book = Book.new
  end
end
