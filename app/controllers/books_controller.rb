class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  #before_action :user_info_new_book, only: [:index, :show]

  #def ensure_current_user#正しいユーザかを確かめる
  #    @book = Book.find(params[:id])
  #  if @book.user_id != current_user.id
  #    redirect_to books_path
  #  end
  #end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @book.user_id = current_user.id
    if @book.save
    # 4. トップ画面へリダイレクト
      redirect_to book_path(@book.id)
      flash[:notice] = "Book was successfully created."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    # テンプレート化するために、@userに@book.userを格納
    @user = @book.user
    # show内（book詳細）に投稿を置く場合、newが必要
    @book_show = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    flash[:notice] = "Book was successfully destroyed."
    redirect_to "/books"  # 投稿一覧画面へリダイレクト
  end

    private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    #@book.user_id = params[:id].to_i
  unless @book.user.id == current_user.id
    redirect_to books_path
    #@book = Book.find(params[:id])
    #unless @book.user_id == current_user.id
    # redirect_to books_path
  end
  end
end