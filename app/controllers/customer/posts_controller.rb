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
    @post = Post.new
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @posts = @posts.page(params[:page])
    end
  end

  def show
    @bookmark_count = Bookmark.where(post_id: params[:id]).count
    @post = Post.find(params[:id])
    @comments = @post.comments
    @posts = @post.post_tags.page(params[:page])
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @post = current_customer.posts.build
    @postnew = Post.new
  end

  def create
    @post = current_customer.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @post.customer.name
  end

  def update
    @post = current_post
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.save_tags(params[:post][:tag])
      redirect_to root_path
    else
      render :edit
    end
  end

def destroy
  @post = Post.find(params[:id])
  @post.destroy
    redirect_to posts_path
end


  def find_post
    @post = Post.find(params[:id])
  end

  def force_redirect_unless_my_post
    return redirect_to root_path, alert: "権限がありません" if @post.customer != current_customer
  end

  def bookmarks
    @posts = current_customer.bookmarks_posts
  end

  def search
    @posts = Post.all
    @tags = Tag.all
    @customers = Customer.search(params[:keyword])
    if params[:keyword].present?
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
    @tag_list = Tag.all
    @customers = Customer.all
    if params[:name].present?
      @customerrs = Customer.where("post LIKE ?", "%#{params[:post]}%")
    else
      @customers = Customer.none
    end
  end

  def hashtags
    if params[:hashtags].present?
      tag_name = params[:hashtags].downcase
      tag = Tag.find_by(tag_name: tag_name)
      if tag.nil?
        @posts = Kaminari.paginate_array([]).page(params[:page]).per(8)
      else
        @posts = tag.posts.page(params[:page]).per(8)
      end
    else
      @posts = Post.all.page(params[:page]).per(8)
    end
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
  
  private

  def ensure
    @post = current_customer.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end

  private

  def post_params
    params.require(:post).permit(:image, :address, :introduction, :hash_tags, :name)
  end
end
