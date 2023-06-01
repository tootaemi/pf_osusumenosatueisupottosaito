class Customer::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # パラメーターを受け取り保存準備
    @post = Post.new(post_params)

    # Postを保存
    if @post.save
      # タグの保存
      @post.save_tags(params[:post][:tag])
      # 成功したらトップページへリダイレクト
      redirect_to root_path
    else
      # 失敗した場合は、newへ戻る
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      # タグの更新
      @post.save_tags(params[:post][:tag])
      # 成功したら投稿記事へリダイレクト
      redirect_to post_path(@post)
    else
      # 失敗した場合は、editへ戻る
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy()
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end






class Customer::PostsController < ApplicationController

  def new
    @post = Post.new
  end
  

  # before_action :find_post, only: [:edit, :update, :show, :destroy]


 def top
  @user = User.find(params[:id])
  if @user.save
   flash[:notice] = "Welcome! You have signed up successfully."
   redirect_to user_path(@users.id)
  else
    render :index
  end
 end

# def new
#   @post = Post.new
# end

 def index
  @posts = Post.all
  @customers = Customer.all
  @post = Post.new
  @customer = current_customer

 end

 def show
  @post_new = Post.new
  @post = Post.find(params[:id])
  @customer = @post.customer
  @nickname = user.nickname
  @posts = user.posts
 end

    # def index
    #     @posts = Post.all
    #     @post = Post.new
    # end

    def new
      @post = Post.new
      @customer = Customer.new
    end
    

    def edit
      @post = Post.find(post_params)
      @post.customer.name
    end

  def create
      @post = current_customer
          @posts = Post.all

      # @post = Post.create 
      # params.require(:post).permit(:content, images: []) 
   @post.save
        redirect_to post_path,notice:'投稿に成功しました'
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end
    
    

      def update
        if @post.update(post_params)
          redirect_to root_path
        else
          render :edit
        end
      end

      def destroy
        if @post.destroy
          redirect_to root_path,alert: '投稿を削除しました'
        else
          redirect_to root_path
        end
      end

      # private
      #   def post_params
      #     params.require(:post).permit(:content, images: [])
      #   end

        def find_post
          @post = Post.find(params[:id])
        end

        def force_redirect_unless_my_post
          return redirect_to root_path,alert:'権限がありません'if @post.user != current_user
        end
        

        
end



  def index
    @post = Post.new
    @posts = Post.all

    # @posts = Post.page(params[:page]).per(10)
  end


  def show
    @post = Post.find(params[:id])
     @nickname = user.nickname
    @posts = user.posts
  end


def new
    @post = Post.new
end


  def create
    @post = Post.new(post_params)
    @posts = Post.all
    @post.save
    redirect_to customer_post_path(@post.id)
    #@post.save ? (redirect_to customer_post_path(@post)) : (render :new)
  end



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


  def update
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



  private
   def post_params
    params.require(:post).permit(:image, :address, :introduction, :tag, :customer_id)
   end


# class Customer::RegistrationsController < Devise::RegistrationsController
