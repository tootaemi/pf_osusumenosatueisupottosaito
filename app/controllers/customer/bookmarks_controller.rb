class Customer::BookmarksController < ApplicationController
    before_action :authenticate_customer!

  def index
      @bookmarks = Bookmark.all
      @customer = current_customer
      @post = Post.new
      @posts = Post.all
      @customers = Customer.all
      #@bookmarked_bys = @bookmark.all
  end


    def bookmark
      # @bookmarks = Bookmark.all
      @bookmarks = Bookmark.find(params[:bookmark_id])
      # bookmarkのリレーションにboardを入れる、user_idはcurrent_userとするのだろう
      bookmarks_path << @posts
    end

    # def show
    #     # @bookmark = Bookmark.find(params[:bookmark_id])
    #     @bookmarks = @bookmark.all
    # end

    def create
    @post = Post.find(params[:post_id])
    if current_customer.nil?
　　　　# ログインしていない場合(ゲスト)
      if cookies[:bookmaer_post_id].nil?
        #cookieがブラウザに保存されていない場合
        cookies.permanent[:bookmaer_post_id] = @post.id.to_s
      else
        #cookieがブラウザに保存されている場合
        cookies.permanent[:bookmaer_post_id] = cookies.permanent[:bookmaer_post_id] + "," + @post.id.to_s
      end
      Bookmaer.create(customer_id: nil, post_id: @post.id)    # 「user_idがnil」のレコードを追加
      @bookmaers_count = @post.bookmaers.count    #いいね数の表示
      @cookies = cookies[:bookmaer_post_id]     #インスタンス変数化
    else
      # ログインしている場合(詳しい説明は省略)
      @bookmarks = current_customer.bookmarks.new(post_id: @post.id)
      @bookmaers_count = @post.bookmarks.count
    end
    
      post = Post.find(params[:post_id])
      bookmark = current_customer.bookmarks.new(post_id: post.id)
      bookmark.save
      redirect_to post_path(post)
      @post_bookmark = Bookmark.new(customer_id: current_customer.id, post_id: params[:post_id])
      #@bookmark = @post.bookmarks.new(customer_id: current_customer.id)
      if bookmark.save
        # redirect_to request.referer
      # else
      #   redirect_to request.referer
      end
        @post_bookmark = Bookmark.new(customer_id: current_customer.id, post_id: params[:post_id])
        @post_bookmark.save
        # redirect_to post_path(params[:post_id])
        @post_bookmark.destroy
        # @bookmark = Bookmark.find(params[:id])
        bookmarks_path
        current_customer.unbookmark(post)
        # 元のコード　bookmark = current_user.bookmarks.build(board_id: params[:board_id])
        # 元のコード　bookmark.save!
        # redirect_to posts_path, success: t('.success')
        # end
        # @bookmark = Bookmark.find(params[:bookmark_id])
        post = Post.find(params[:post_id])
        bookmark = current_customer.bookmarks.new(post_id: post.id)
        # bookmark = @post.bookmarks.new(customer_id: current_customer.id)
        bookmark = current_customer.bookmarks.new(customer_id: current_customer.id)
        # bookmark.save
        # redirect_to posts_path
    end

  def destroy
    @post = Post.find(params[:post_id])
    if current_customer.nil?
      # (今回、ゲストのいいね取消し機能は実装しませんでした。)
    else
      # ログインしている場合(説明は省略)
      @bookmaer = current_customer.bookmaers.find_by(post_id: @post.id)
      @bookmaer.destroy
    end
      
      
      post = Post.find(params[:post_id])
      # bookmark = Bookmark.find(params[:bookmark_id])
      bookmark = Bookmark.find(params[:id])
      bookmark = @post.bookmarks.find_by(customer_id: current_customer.id)
      if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
      else
          redirect_to request.referer
      end
      @bookmark = Bookmark.find(params[:id])
      @bookmark = current_customer.bookmarks.find_by(post_id: post.id)
      bookmark.destroy
      redirect_to post_path(post)
    # 中間テーブルを取り出して、そのboardを取り出している。belong_toで紐づいているからboardで取り出せる。
    # post = current_customer.bookmarks.find(params[:id]).post
    # current_customer.bookmarks(@post)
    # 元々のコード　current_user.bookmarks.find(params[:id]).destroy!
    redirect_to posts_path, success: t('.success')

    bookmark = current_customer.bookmark.find_by(customer_id: current_customer.id)
    bookmark.destroy
    redirect_to customer_path
    @post = Post.find(params[:post_id])
    bookmark = current_customer.bookmarks.find_by(post_id: post.id)
    redirect_to post_path(post)
  end

  def unbookmark(post)
    bookmark_posts.destroy(@post)
  end
end