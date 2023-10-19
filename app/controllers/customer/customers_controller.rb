class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:bookmarks]


  def top
    @customers = Customer.limit(4).order("id DESC")
    @customers = Customer.all
  end

  def show
    @customer = current_customer
    @customers = Customer.where(id: params[:id])
  end

  def search
    @collections = Collection.search(params[:keyword])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customers = Customer.all
    if redirect_to post_new_path(@post)
    else
      @customers = @post.customers.includes(:customer)
      render :index
    end
  end

  def update
    @customer = current_customer
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if current_customer.id == @customer.id && @customer.destroy
      redirect_to :root
    else
      redirect_to :root
    end
  end

  def destroy_confirm
    @customer = current_customer
  end

  def destroy_customer
    @customer = current_customer
    if @customer.email == 'test@test.com"'
      reset_session
      redirect_to :root
    else
      @customer.update(is_valid: false)
      reset_session
      redirect_to :root
    end
  end

  def bookmarks
    @bookmarks = Bookmark.where(customer_id: @customer.id).pluck(:post_id)
    @bookmark_posts = Post.find(bookmarks)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password)
  end
end