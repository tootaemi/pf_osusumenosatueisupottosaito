class Customer::CustomersController< ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:bookmarks]
#   def withdraw; end

#   def withdraw
#     current_customer.update(status: 'withdrawn')
#     reset_session
#     redirect_to root_path
#   end


#   def index
#       @customer = Customer.find(params[:id])
#   end

#   def new
#       @customer = Customer.find(params[:id])
#     @customer = Customer.all
#   end

#   def create
#     @customer = Customer.new(params[:id])
#   end

#     private
#   def customer_params
#     params.require(:customer).permit(:last_name, :first_name)
#   end


# end











  def top
    # @customer = Customer.limit(4).order('id DESC')
    # @customers = Customer.page(params[:page]).per(8)
    # @customer = current_customer
    # @customer = Customer.new
    @customers = Customer.limit(4).order('id DESC')
    @customers = Customer.all
    # @posts = Post.all
  end


  def index
    @customer = current_customer
    @post = Post.new
    @posts = Post.all
    @customer = Customer.new
    @customers = Customer.all

#@customers = Customer.paginate(page: params[:page], per_page: 5).search(params[:search])
  end


  def show
    @bookmarks = Bookmark.where(id: params[:id])
    # @customer = Customer.find(params[:id])
    @customer = current_customer
    @customers = Customer.where(id: params[:id])
    # @customers = Customer.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
    @posts = Post.where(id: params[:id])
    @customer = Customer.all
    @customer = Customer.new
    @posts = Post.all

    @post = @customer.posts
    @post_new = Post.new
    # @customer = Customer.find(params[:id])
    @posts = @customer.posts
    # @bookmark_posts = @customer.bookmark_ids

  end

  def edit
    @customer = Customer.find(params[:id])
  end


  def new
    @customer = Customer.new
  end


   #redirect_to customer_post_path(@customer.id)

   def create
     # @customer = Customer.new(customer_params)
     @customers = Customer.all
    if
      redirect_to post_new_path(@post), notice: 'メッセージが送信されました'
    else
     @customers = @post.customers.includes(:user)
      render :index
    end
   end


#  def update
#   @customer = Customer.find(params[:id])
#    if @customer.update(customer_params)
#       redirect_to admin_customer_path
#    else
#     render :admin_customer_path
#    end

#  end

  # end


#   def update
#      @customer = Customer.find(params[:id])
#      @customer.update(customer_params)
#      redirect_to admin_customer_path(@customer)
#   end

#   def update
#   @customer = Customer.find(params[:id])
#    if @customer.update(customer_params)
#       redirect_to admin_customer_path
#    else
#     render "edit"
#    end

#   end

# def update
#         @customer = current_customer
#         if @customer.update(customer_params)
#         # flash[:update] = "You have updated user info successfully."
#         redirect_to customer_path(@customer.id)
#         else
#         render 'edit'
#         end
# end

    def destroy
      # @customer = Customer.find(params[:id])
      # @Customer.new(params[:id]).destroy
      # redirect_to customers_sign_out_path
    end



  def bookmarks
    @bookmarks = Bookmark.where(customer_id: @customer.id).pluck(:post_id)
    @bookmark_posts = Post.find(bookmarks)
  end

private
  def set_customer
    @customer = Customer.find(params[:id])
  end


  private
   def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password)
   end


end