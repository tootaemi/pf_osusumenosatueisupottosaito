class Customer::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :update, :destroy]

 def top
  @post = Post.find(params[:id])
  if @post.save
   redirect_to post_path(@posts.id)
  else
    render :index
  end
 end

    def index
      @customers = Customer.all
      @bookmarks = Bookmark.all
      @customer = Customer.new
      @customer = current_customer
      @tag_list = Tag.all
      # @posts = current_customer.posts.all  #投稿一覧を表示させるために全取得
      @posts = Post.limit(8).order('id DESC')
      @post = Post.all.page(params[:page]).per(10)
      @posts = Post.page(params[:page])
      @posts = Post.new(params[:search])
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    keyword = params[:keyword]
    if keyword.present?
      #@posts = @posts.each(params[:post_tag]).page(params[:page])
      @posts = Post.search(keyword)
      #@posts = Array[:items][:data][0][:price][:product].page(:params[:page]).per(10)
      #@posts = @posts.search(params[:keyword]).page(params[:page])
    else
      # @posts = @posts.page(params[:page])
    end
    @keyword = keyword
    #@customer = Customer.find(params[:hash_tags])
    # @posts = @customer.posts.search.where(indicater_reply_edit: "承認").order("worked_on ASC")
  @posts = Post.all
  @keyword = params[:keyword]
  tag = params[:keyword].present? ? Tag.find_by(tag_name: params[:keyword]) : nil
  if params[:keyword].present?
    keyword = params[:keyword].gsub(/[#＃]/,"")
    tag = Tag.find_by(tag_name: keyword)
    @posts = tag.nil? ? Post.all : tag.posts
  else
    @posts = Post.all
  end
    # @posts = current_customer.posts

 @post = Post.new
    @posts = Post.page(params[:page]).per(8)
     @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @posts = @posts.page(params[:page])
    end
    @keyword = params[:keyword]
    end

def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:customer)
    @bookmark_count = Bookmark.where(post_id: @post.id).count

    # @customer = Customer.find(params[:id])
    @customer = Customer.where(id: params[:id])
    # @post = Post.find(params[:id])

    @posts = customer_path
    @posts= Post.all
    @hash_tags = @hash_tag
    @comment = Comment.where(id: params[:id])


  @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
     if @comment.nil?
      @comments = []
     else
      @comments = @post.comments
     end
    @posts = @post.post_tags.page(params[:page])
    # @comments = @post.comments.includes(:customer)
    # @customer = Customer.find(params[:id])
    @post = Post.find(params[:id])
    @posts = @post.post_tags.page(params[:page])


    # @comment = Comment.new
    # @comments = @tweet ? @tweet.comments.includes(:user) : []

   @comment = Comment.new
   # @comment = current_customer.Comment.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得

end


  def new
    @post = Post.new
    @post = current_customer.posts.build
    @postnew = Post.new
  end


    def create
      # @post = current_customer.posts.new(post_params)  # current_userはdeviseが用意してくれる、ログイン最中のユーザーを表す

      @post = Post.new(post_params)
      # @post = Post.find(post_params)
        @post.customer_id = current_customer.id
      @posts = Post.all
      @post.save
      redirect_to root_path(@post.id)
    @postnew = Post.new(post_params)
     @post = current_customer.posts.new(post_params)
    end

    def edit
      @post = Post.find(params[:id])
      # @post = Post.find(1)
      # @post = Post.find(post_params)
      @post.customer.name
    end

  def update
    @post = current_post
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.save_tags(params[:post][:tag])
          redirect_to root_path

      # redirect_to posts_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(@post)

    redirect_to post_path(params[:post_id])

    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path
	    Post.find_by( params[:id]).destroy
  end

        def find_post
          @post = Post.find(params[:id])
        end

        def force_redirect_unless_my_post
          return redirect_to root_path,alert:'権限がありません'if @post.user != current_user
        end


def search
  @posts = Post.all
  @tags = Tag.all
  @customers = Customer.search(params[:keyword])


    if params[:keyword].present?
      @photos = Tag.where('caption LIKE ?',"%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end

    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    #@tag = Tags.find(params[:tag_id])  #クリックしたタグを取得
    #@posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
    @customers = Customer.all

    if params[:name].present?
      @customerrs = Customer.where('post LIKE ?', "%#{params[:post]}%")
    else
      @customers = Customer.none
    end
end

    def bookmarks
      @posts = current_customer.bookmarks_posts
    end


def hashtags
  if params[:hashtags].nil?
   @hashtags = Tag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    @hashtags = Tag.all.group(:tag_name)
  else
    name = params[:hashtags]
    name = name.downcase
    @hashtag = Tag.find_by(tag_name: name)
    if @hashtag.nil?
      @posts = []
    else
      @posts = @hashtag.posts
    end
    @hashtags = Tag.all.group(:tag_name)
  end
  # @hashtags = Hashtag.all.page(params[:page]).per(10)
  #@hashtags = Hashtag.all.page(params[:page]).per(10)
  @hashtags = @hashtags.all.page(params[:page])

  # @hashtags = Hashtag.all.page(params[:page]).per(10)
     
end


  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post  was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


private
  def ensure
    @post = current_customer.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end


private
  def post_params
    params.require(:post).permit(:image, :address, :introduction, :hash_tags, :name)
    #.merge(user_id: current_customer.id)
  end

end
