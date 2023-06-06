class Customer::HomesController< ApplicationController
  def top
    # @customers = Customer.all
    @customers = Customer.limit(4).order('id DESC')
    @customer = Customer.limit(4).order('id DESC')
    # @customers = Customer.page(params[:page]).per(8)
    @customer = current_customer
    @customer = Customer.new
    @customers = Customer.all
    @posts = Post.all
  end
  
  
 def top
  # @customer = Customer.new(params[:id])
  
  @posts = Post.all
  @customers = Customer.all
  @post = Post.new
  @customer = current_customer
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