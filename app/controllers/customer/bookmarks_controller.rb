class Customer::BookmarksController < ApplicationController
    
    def index
      @bookmarks = Bookmark.all
      @post = Post.new
      @posts = Post.all
      @customers = Customer.all
      @bookmarks = Bookmark.where(customer: current_customer.id)
      #@bookmarked_bys = @bookmark.all
      @bookmarks = Bookmark.page(params[:page]).per(8)
    end
    
    def show
      @bookmark = Bookmark.find(params[:id])
      @customer = Customer.find(params[:id])
    end



  def create
    @bookmarke = current_customer.bookmarks.find_or_create_by(post_id: params[:post_id])
  
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @bookmark = current_customer.bookmarks.find_by(post_id: params[:post_id])
    @bookmark.destroy if @bookmark
    redirect_back(fallback_location: root_url)
  end

  private
   def customer_params
    params.require(:bookmark).permit(:customer_id, :post_id)
   end


end