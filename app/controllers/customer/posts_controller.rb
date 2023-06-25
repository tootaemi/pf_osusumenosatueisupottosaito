class Customer::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :update, :destroy]
  # before_action :ensure_customer, only: [:edit, :update, :destroy]

 def top
  @post = Post.find(params[:id])
  if @post.save
   redirect_to post_path(@posts.id)
  else
    render :index
  end
 end

 def index
  @posts = Post.all
  @customers = Customer.all
  @bookmarks = Bookmark.all
  @post = Post.new
  @customer = Customer.new
  @customer = current_customer

  @tag_list = Tag.all
  @posts = current_customer.posts.new

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
end


  def new
    @post = Post.new
    @post = current_customer.posts.build
  end

    def create
      # @post = current_customer.posts.new(post_params)  # current_userはdeviseが用意してくれる、ログイン最中のユーザーを表す
       @post = Post.new(post_params)
        @post.customer_id = current_customer.id
        if @post.save
          redirect_to root_path(@post)
        else
            @posts = Post.all
            render 'show'
    # @post = current_customer.posts.build(post_params)
    # if @post.save
    #   redirect_back(fallback_location: root_path)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
        end
    


# def create
#   @post = Post.new(post_params)
#   @posts = Post.all
#   @posts.save
#   redirect_to post_path
    end


    def edit
      @post = Post.find(params[:id])
      # @post = Post.find(post_params)
      @post.customer.name
    end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.save_tags(params[:post][:tag])
      redirect_to post_path(@post)
    else
      render :edit
    end
  end



  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
    
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path
	    Post.find_by( params[:id]).destroy
	    redirect_to post_path(@post)
  end



  # def create
  #   @message = @group.messages.new(message_params)
  #   if @message.save
  #     redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
  #   else
  #     @messages = @group.messages.includes(:user)
  #     flash.now[:alert] = 'メッセージを入力してください。'
  #     render :index
  #   end
  # end


  # def create
  #     @post = current_customer
  #         @posts = Post.all

  #     # @post = Post.create
  #     # params.require(:post).permit(:content, images: [])
  # @post.save
  #       redirect_to posts_path,notice:'投稿に成功しました'
  #   # @post = Post.new(post_params)
  #   current_customer = current_customer
  #   # @post.save
  #   # redirect_to new_post_path
  # end


        def find_post
          @post = Post.find(params[:id])
        end

        def force_redirect_unless_my_post
          return redirect_to root_path,alert:'権限がありません'if @post.user != current_user
        end






  # def create
  #   @post = Post.new(post_params)
  #   @posts = Post.all
  #   @post.save
  #   redirect_to customer_post_path(@post.id)
  #   #@post.save ? (redirect_to customer_post_path(@post)) : (render :new)
  # end



# def create
#   @post = Post.new(post_params)
#   @post.user_id = current_user.id
#   if @post.save
#       redirect_to post_path(@post)
#   else
#       @posts = Post.all
#       render 'index'
#   end
# end

  def search
    if params[:keyword].present?
      @photos = Photo.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @photos = Photo.all
    end
  end



def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    # @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    # @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
end

# ~
# ~
# def search
#   @section_title = "「#{params[:search]}」の検索結果"
#   @posts = if params[:search].present?
#             Post.where(['shop_name LIKE ? OR nearest LIKE ?',
#                         "%#{params[:search]}%", "%#{params[:search]}%"])
#                 .paginate(page: params[:page], per_page: 12).recent
#           else
#             Post.none
#           end
# end
# ~
# ~



  # def search
  #   if params[:name].present?
  #     @users = User.where('name LIKE ?', "%#{params[:name]}%")
  #   else
  #     @users = User.none
  #   end
  # end



  def edit
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
  # before_action :find_post, only: [:edit, :update, :show, :destroy]

