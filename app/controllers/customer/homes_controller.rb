class Customer::HomesController< ApplicationController


   # before_action :authorize
   
    # def mypage
    #     @bookmarks = Bookmark.where(user_id: current_user.id)
    # end

    def top
  @posts = Post.limit(8).order('id DESC')

    # @customers = Customer.all.order("id DESC")
    # @customers = Customer.limit(4).order('id DESC')
   #@customer = current_customer.id
    # @customer = current_customer
    @customer = Customer.new
    @customers = Customer.all
    @posts = Post.all
    @post = Post.new
    @posts = @posts.page(params[:page])
    end


 def index
  @posts = Post.all
  @customers = Customer.all
  @post = Post.new
  @customer = current_customer
  @bookmarks = Bookmark.where(user_id: current_user.id)
 end


private
  def home_params
    params.require(:home).permit(:image, :address, :introduction, :hash_tags, :name)
  end

end