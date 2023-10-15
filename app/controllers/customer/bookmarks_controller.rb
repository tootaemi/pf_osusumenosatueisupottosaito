class Customer::BookmarksController < ApplicationController
  before_action :posts_path

  def index
    @bookmarks = Bookmark.where(customer: current_customer.id)
    @bookmarks = @bookmarks.page(params[:page]).per(8)
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @customer = Customer.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    if current_customer.nil?
      if cookies[:bookmark_post_id].nil?
        cookies.permanent[:bookmark_post_id] = @post.id.to_s
      else
        cookies.permanent[:bookmark_post_id] = cookies.permanent[:bookmark_post_id] + "," + @post.id.to_s
      end
      Bookmark.create(customer_id: nil, post_id: @post.id)
      @bookmarks_count = @post.bookmarks.count
      @cookies = cookies[:bookmark_post_id]
    else
      @bookmark = current_customer.bookmarks.new(post_id: @post.id)
      @bookmark.save
      @bookmarks_count = @post.bookmarks.count
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    if current_customer.nil?
    else
      @bookmark = current_customer.bookmarks.find_by(post_id: @post.id)
      @bookmark.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def customer_params
    params.require(:bookmark).permit(:customer_id, :post_id)
  end
end
