class Admin::HomesController < ApplicationController
  def index
    @customers = Customer.all
  end

  def top
    # if customer_signed_in?
    #   @note = Note.new
    #   @notes = Note.all.order(created_at: :desc)
    # else
    #   @message = "ようこそKotoritterへ！"
    # end
    @customer = Customer.new
    # @customers = Customer.page(params[:page]).per(10)
    @customer = current_customer
    @customer = Customer.new
    @customers = Customer.all
    @posts = Post.all
  end

  def about
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password)
  end
end