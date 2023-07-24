class Admin::HomesController < ApplicationController
    def index
      @customers = Customer.all
    end
    
    def top
      @customer = Customer.new
      @customer = current_customer
      @customer = Customer.new
      @customers = Customer.all
      @posts = Post.all
      @customers = Customer.all.page(params[:page]).per(10)
    end
    
    private
    def customer_params
      params.require(:customer).permit(:name, :email, :encrypted_password)
    end
end