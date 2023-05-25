class Customer::PostsController < ApplicationController


  def index
    @post = Post.new
    # @posts = Post.page(params[:page]).per(10)
  end


  def show
    @post = Post.find(params[:id])
  end
  

def create
   @post = Post.new(post_params)
   @post.user_id = current_user.id
   if @post.save
      redirect_to post_path(@post)
   else
      @posts = Post.all
      render 'index'
   end
end
  
def create
  @post = Post.new(post_params)
  # @posts = Post.all
  @post.save
   redirect_to customer_post_path
   #(@post.id)
end



  private
   def post_params
    params.require(:post).permit(:image, :address, :introduction, :tag)
   end


end

# class Customer::RegistrationsController < Devise::RegistrationsController
