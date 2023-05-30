class Customer::PostsController < ApplicationController

  before_action :find_post, only: [:edit, :update, :show, :destroy]


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
  @post = Post.new
  @customer = current_customer
  @posts = Post.all
  @customers = Customer.all
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
        
  private
   def post_params
    params.require(:post).permit(:image, :address, :introduction, :tag, :customer_id)
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

  private
   def post_params
    params.require(:post).permit(:image, :address, :introduction, :tag, :customer_id)
   end


# class Customer::RegistrationsController < Devise::RegistrationsController
