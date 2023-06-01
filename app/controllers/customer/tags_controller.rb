class Customer::TagsController < ApplicationController

  def top
    @tags = Tag.all
  end

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end

end