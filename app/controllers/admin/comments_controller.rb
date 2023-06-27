class Admin::CommentsController < ApplicationController

def index
    @comments = Comment.all
    @comment = Comment.new
    @customers = Customer.all
    @customer = Customer.new
    @posts = Post.all
    @post = Post.new
    #@comments = Comment.page(params[:page]).per(10)
    @comment = Comment.all.order("created_at DESC")
end

def show
    @comments = Comment.all
    @comment = Comment.new
    @customers = Customer.all
    @customer = Customer.new
    @posts = Post.all
    @post = Post.new
    #@comments = Comment.where(id: params[:id])
    # @comments = Comment.find(params[:id])
    # @posts = Post.find(params[:id])
    @comment = Comment.all
    #.order("created_at DESC")

end

  def create
    @comment = current_customer.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end



  private
    def comment_params
      params.require(:comment).permit(:id, :customer_id, :post_id, :comment)
    end


end