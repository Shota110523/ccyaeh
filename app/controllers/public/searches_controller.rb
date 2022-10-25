class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
    elsif @range == "PostTitle"
      @posts = Post.looks_title(params[:search], params[:word])
    else
      @posts = Post.looks_body(params[:search], params[:word])
    end
  end
end
