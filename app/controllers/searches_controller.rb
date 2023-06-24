class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render "searches/search_result"
    else
      @books = Book.looks(params[:search], params[:word])
      render "searches/search_result"
    end
  end
end

#検索モデル->params[:range]
#検索方法  ->params[:search]
#検索ワード->params[:word]

#条件分岐をつかって、検索モデルを分ける

#looksメソッドを使い、検索内容を取得し、変数に代入。
  #params[:search]とparams[:word]を参照してデータを検索し、
  #インスタンス変数（@usersもしくは@books)に検索結果を代入。
