class Customer::BookmarksController < ApplicationController
    
    def index
      @bookmarks = Bookmark.all
      @post = Post.new
      @posts = Post.all
      @customers = Customer.all
      #@bookmarked_bys = @bookmark.all
    end
    
    def show
      @bookmark = Bookmark.find(params[:id])
      @customer = Customer.find(params[:id])
    end



def create
  @bookmarke = Bookmark.new(customer_id: current_customer.id, post_id: params[:post_id])
  @bookmark
  redirect_to post_path(params[:post_id]) 

    # bookmark = current_customer.bookmarks.build(post_id: params[:post_id])
    # @bookmark = Bookmark.new(customer_id: current_customer.id, post_id: params[:post_id])
    # bookmark_path
    # redirect_to posts_path
    # redirect_to "/posts/#{@bookmark.post_id}"
    
    post = Post.find(params[:post_id])
    bookmark = current_customer.bookmarks.new(post_id: post.id)
    bookmark.save
    # redirect_to post_path(post)

end

  def destroy
    bookmark = Bookmark.find_by(post_id: params[:post_id], customer_id: current_customer.id)
    bookmark
    redirect_to posts_path(@post)
    
    @bookmark = Bookmark.find_by(customer_id: current_customer.id, post_id: params[:post_id])
    # @bookmark.destroy
    # redirect_to post_path

    post = Post.find(params[:post_id])
    bookmark = current_customer.bookmarks.find_by(post_id: post.id)
    bookmark.destroy
    redirect_to posts_path(@post)
    
  end

  private
   def customer_params
    params.require(:bookmark).permit(:customer_id, :post_id)
   end


end