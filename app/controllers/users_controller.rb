class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # 他人のマイページ表示
  end

  def index
    @users = User.all
    @book = Book.new
    @books = Book.all
    @user = current_user ##@bookぶっくテーブルのuser_idカラムに対してログインしている人のIDを入れる誰がつ
    #findはログインしているユーザー　/books .allだと誰の川畠辛いので指定しなければならない
    # /booksなのでfind(params[:id])は使えないのでログインしている@user = current_user
    # @books = @user.books

  end
  
def create
  @user = User.new(user_params)
  if @user.save
    flash[:notice] = "User was successfully created."
    redirect_to user_path(@user)
  else
    render :new
  end
end

def edit
  @user = User.find(params[:id])
  if @user.id != current_user.id#!@userとカレントユーザーが一緒じゃない場合
    redirect_to user_path(current_user.id) # ユーザーぺーじにリダイレクト
  end
end

def update
  @user = User.find(params[:id])#ユーザーを見つけてくる
  if @user.update(user_params)#もしアップデートのアップデートができたら
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user) # ユーザーぺーじにリダイレクト
  else#もしうまくいかなかったら
   render :edit#もう一度同じページを表示させることによってエラー
  end
end

private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
end
end