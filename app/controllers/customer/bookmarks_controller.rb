class Customer::BookmarksController < ApplicationController
  
def create
  @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
  @post_favorite.save
  redirect_to post_path(params[:post_id]) 
end

def create
  @post_bookmark = Bookmark.new(customer_id: current_customer.id, post_id: params[:post_id])
  @post_bookmark.save
  redirect_to post_path(params[:post_id]) 
end

def create
  @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
  @post_favorite.destroy
  redirect_to post_path(params[:post_id]) 
end

def create
  @post_bookmark = Bookmark.find_by(customer_id: current_customer.id, post_id: params[:post_id])
  @post_bookmark.destroy
  redirect_to post_path(params[:post_id]) 
end



  
  
  def create
    @post = Post.find(params[:post_id])
    bookmark = current_customer.bookmarks.new(post_id: @post.id)
    bookmark.save
    redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @bookmark = current_customer.bookmarks.find_by(post_id: post.id)
    bookmark.destroy
    redirect_to post_path(post)
  end


end
