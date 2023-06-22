class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def set_current_user
    @current_user=User.find_by(id :session[:user_id])
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_comment = BookComment.new
  end

  def index
    @users = User.all
    @book = Book.new
    #@user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def following
    @title = "Follows"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
