class Customer::CustomersController< ApplicationController
  
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
    # @customer = Customer.new
    @posts = Post.all
    @customers = Customer.all
  end

  def show
    @customers = Customer.where(id: params[:id])
    @customers = Customer.where(user_id: current_customer.id).includes(:user).order("created_at DESC")
    @posts = Post.where(id: params[:id])
    @customer = Customer.all
    @customer = Customer.new
    @posts = Post.all

    @post = @customer.posts
    @post_new = Post.new


    # @customer = Customer.find(params[:id])
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




  private
   def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password)
   end

end

#,:image, :address, :introduction, :tag