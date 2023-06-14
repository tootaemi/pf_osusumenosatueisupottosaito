class Customer::HomesController< ApplicationController
 
 
   # before_action :authorize
 
  def top
    # @customers = Customer.all.order("id DESC")
    # @customers = Customer.limit(4).order('id DESC')
   #@customer = current_customer.id
    # @customer = current_customer
    @customer = Customer.new
    @customers = Customer.all
    @posts = Post.all
    @post = Post.new
  end


 def index
  @posts = Post.all
  @customers = Customer.all
  @post = Post.new
  @customer = current_customer
 end
  
  
  #   private
  # def post_params
  #   params.require(:home).permit(:image, :address, :introduction, :tag) 
  # end
  
end