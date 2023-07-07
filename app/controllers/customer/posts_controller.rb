class Customer::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :update, :destroy]

  # before_action :find_post, only: [:edit, :update, :show, :destroy]
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
  @customers = Customer.all
  @bookmarks = Bookmark.all
  @customer = Customer.new
  @customer = current_customer
  @tag_list = Tag.all
  @bookmarks = Bookmark.all
  @posts = current_customer.posts.all  #投稿一覧を表示させるために全取得
  # @customer = Customer.find(params[:id])
    @posts = Post.limit(10).order('id DESC')
    # @posts = @posts.page(params[:page])
  @posts = Post.page(params[:page]).per(10)
  # @posts = @posts.page(params[:page])
  # @posts = Post.all.page(params[:page])
  @posts = Post.all.page(params[:page]).per(10)
  @posts = Post.page(params[:page])
      
      
  @posts = Post.all.page(params[:page]).per(10)



  @posts = Post.new(params[:search])
  
  # @post　= Post.paginates_per.page(5).per(10)
  # @posts = Post.paginates_per.page(params[:page]).per(10)
  # @posts = @posts.page(params[:page])

  # @posts = @customer.posts.page(params[:page])
  # @posts = Post.page(params[:page])

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
    @comment = current_customer.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得

  @post = Post.find(params[:id])
    @posts = @post.post_tags.page(params[:page])
end


  def new
    @post = Post.new
    @post = current_customer.posts.build
    @postnew = Post.new
  end


    def create
      # @post = current_customer.posts.new(post_params)  # current_userはdeviseが用意してくれる、ログイン最中のユーザーを表す
       @post = Post.new(post_params)
        @post.customer_id = current_customer.id
      @post.save
      redirect_to root_path(@post)
    @posts = Post.all
    @postnew = Post.new(post_params)
     @post = current_customer.posts.new(post_params)
    end










# def create
#   @post = Post.new(post_params)
#   @posts = Post.all
#   @posts.save
#   redirect_to post_path
    # end


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
    redirect_to post_path(@post)

    redirect_to post_path(params[:post_id])

    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path
	    Post.find_by( params[:id]).destroy
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



# def search
#     @tag = Tag.all

#   @section_title = "「#{params[:search]}」の検索結果"
#   @posts = if params[:search].present?
#             Post.where(['shop_name LIKE ? OR nearest LIKE ?',
#                         "%#{params[:search]}%", "%#{params[:search]}%"])
#                 .paginate(page: params[:page], per_page: 12).recent
#           else
#             Post.none
#           end
# end


def search
  @posts = Post.all
  @Tags = Tag.all
    @customers = Customer.search(params[:keyword])

    if params[:keyword].present?
      @photos = Tag.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end

    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    #@tag = Tags.find(params[:tag_id])  #クリックしたタグを取得
    #@posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
    @customers = Customer.all
end


def hashtag
    @Tags = Tag.all
  # @tag = Tag.find(params[:hash_tags])
      @tag = Tag.new
  # @posts = @tag.posts
end






  def hashtag
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    else
      name = params[:name]
      name = name.downcase
      @hashtag = Hashtag.find_by(hashname: name)
      @post = @hashtag.posts
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
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

  def destroy
    @post = Post.find(params[:id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
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

def hash_tags
  @tag = Tag.find(params[:tag_id])
  @posts = @tag.posts
end


  private
   def post_params
    params.require(:post).permit(:image, :address, :introduction, :hash_tags, :name)
    #.merge(user_id: current_customer.id)
   end


end

