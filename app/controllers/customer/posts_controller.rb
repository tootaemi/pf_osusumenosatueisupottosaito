class Customer::PostsController < ApplicationController

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
  @post = Post.new
  @customer = current_customer
 end
  



  def show
    @post = Post.find(params[:id])
    @posts = customer_url
  end


  def new
    @post = Post.new
    @customer = Customer.new
  end


  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to post_path(@post.id)
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
        if @post.destroy
          redirect_to root_path,alert: '投稿を削除しました'
        else
          redirect_to root_path
        end
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
    params.require(:post).permit(:image, :address, :introduction, :tag, :customer_id, :tag_id)#.merge(user_id: current_customer.id)
   end

end

  # before_action :find_post, only: [:edit, :update, :show, :destroy]

