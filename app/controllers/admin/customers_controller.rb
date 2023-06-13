class Admin::CustomersController < ApplicationController

  def index
    # @customer = Customer.new
    @customers = Customer.all
    @customer = Customer.new
    #.page(params[:page]).per(10)
  end

  def show
    #   @customer = Customer.new
    # @customers = Customer.all
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end



  # def update
  #   @customer = Customer.find(params[:id])
  #   if @customer.update(customer_params)
  #     redirect_to admin_customer_path(@customer)
  #   else
  #     render "show"
  #   end


	def update
		@customer = Customer.find(params[:id])
			if @customer.update(customer_params)
			   redirect_to admin_customer_path
			else
				render :admin_customer_path
			end

	end

  # end


#   def update
#      @customer = Customer.find(params[:id])
#      @customer.update(customer_params)
#      redirect_to admin_customer_path(@customer)
#   end

#   def update
# 		@customer = Customer.find(params[:id])
# 			if @customer.update(customer_params)
# 			   redirect_to admin_customer_path
# 			else
# 				render "edit"
# 			end

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
    params.require(:customer).permit(:id, :name, :email, :encrypted_password)
   end


end