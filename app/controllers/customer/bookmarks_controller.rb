class Customer::BookmarksController < ApplicationController

    def index
      @bookmarks = Bookmark.all
      @post = Post.new
      @posts = Post.all
      @customers = Customer.all
      #@bookmarked_bys = @bookmark.all
    end
    

  def create
    
    # bookmark = current_customer.bookmarks.build(post_id: params[:post_id])
  
    
    # @bookmark = Bookmark.new(customer_id: current_customer.id, post_id: params[:post_id])
    @bookmark
        redirect_to posts_path
    # redirect_to "/posts/#{@bookmark.post_id}"
  end

  def destroy
    
    
    bookmark = Bookmark.find_by(post_id: params[:post_id], customer_id: current_customer.id)
    bookmark.destroy
    redirect_to posts_path
    
    @bookmark = Bookmark.find_by(customer_id: current_customer.id, post_id: params[:post_id])
    @bookmark.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end

end
  

  