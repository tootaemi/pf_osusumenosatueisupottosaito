class Customer::HomesController < ApplicationController
  
  def top
    @posts = Post.all
    @posts = @posts.page(params[:page])
  end
  
  private
  
  def home_params
    params.require(:home).permit(:image, :address, :introduction, :hash_tags, :name)
  end
end