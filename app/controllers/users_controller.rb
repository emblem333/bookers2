class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    # @userに紐付いたbooksのみを表示
    @books = @user.books.all
    # show内（ユーザ詳細）に投稿を置く場合、newが必要
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to user_path(@user.id)
        flash[:success] = "You have updated user successfully."
    else
      render :edit
    end
  end

  def create
    #@post_image = PostImage.new(post_image_params)
    #@post_image.user_id = current_user.id
    #@post_image.save
    #redirect_to post_images_path
  end

  private

  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    #user_id = params[:id].to_i
  unless @user.id == current_user.id
    redirect_to user_path(current_user)
    #@book = Book.find(params[:id])
    #unless @user.id == current_user.id
    #  redirect_to user_path
  end
  end
end