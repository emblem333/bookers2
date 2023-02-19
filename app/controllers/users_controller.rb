class UsersController < ApplicationController
  def index
  end
  
  def edit
  end

  def update
  end
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end

  private

  def user_params
      params.require(:user).permit(:name, :image)
  end
end
