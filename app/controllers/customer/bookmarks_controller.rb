class Customer::BookmarksController < ApplicationController
     before_action :posts_path



    def index
      @post = Post.new
      @posts = Post.all
      @customers = Customer.all
      @bookmarks = Bookmark.where(customer: current_customer.id)
      #@bookmarked_bys = @bookmark.all
      @bookmarks = @bookmarks.page(params[:page]).per(8)
    end

    def show
      @bookmark = Bookmark.find(params[:id])
      @customer = Customer.find(params[:id])
    end





  def create
       post = Post.find(params[:post_id])
   current_customer.bookmark(post)
   redirect_back fallback_location: root_path

    # Bookmark.create(customer_id: current_customer.id, post_id: params[:id])
    # redirect_to posts_path


  end

  def destroy

   post = Post.find(params[:post_id])
   current_customer.unlike(post)
   redirect_back fallback_location: root_path

    # Bookmark.find_by(customer_id: current_customer.id, post_id: params[:id]).destroy
    # redirect_to posts_path
  end



  private
   def customer_params
    params.require(:bookmark).permit(:customer_id, :post_id)
   end


end