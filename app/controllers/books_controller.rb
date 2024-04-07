class BooksController < ApplicationController

  def show
     @book_new = Book.new  #@book_new にする理由は下の@bookとかぶるため
     @book = Book.find(params[:id])
     @user = @book.user
     @books = @user.books
  end
  
  def index
    @book = Book.new #新しく作成するからばこ
    @books = Book.all
    @user = current_user ##@bookぶっくテーブルのuser_idカラムに対してログインしている人のIDを入れる誰がつ
    #findはログインしているユーザー　/books .allだと誰の川畠辛いので指定しなければならない
    # /booksなのでfind(params[:id])は使えないのでログインしている@user = current_user
    # @books = @user.books

  end

  def create
    @book = Book.new(book_params) #新規作成された白紙の本にフォームから送られたtitle,bodyを取得
    @book.user_id = current_user.id#白紙の本（title,body追記済み）に作者（user_id)として今ログインしてるUserのidを追記
    if @book.save#本を保存
       flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book) #保存した本の詳細ページに飛ぶ
    else#本の保存に失敗
      @books = Book.all #@booksに全ての本を代入
      @user = current_user
      render :index #そのままindexが表示される
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
    # @books = Book.all #一覧表示をするのに必要
      render :edit
    end
  end

def destroy
  book = Book.find(params[:id])  # データ（レコード）を1件取得
  if  book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # へリダイレクト
    flash[:notice] = "Book was successfully destroyed."
  end
end

  private

  def book_params#タイトルとボディが送られてくる設定
     params.require(:book).permit(:title, :body)
  end
end