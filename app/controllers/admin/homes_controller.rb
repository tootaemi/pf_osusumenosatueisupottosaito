class Admin::HomesController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def top
    @customers = Customer.all.page(params[:page]).per(10)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password)
  end
end