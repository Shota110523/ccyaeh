class Admins::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  def destroy
      @customer = Customer.find(params[:id])
      @customer.destroy
      flash[:notice] = 'ユーザーを削除しました。'
      redirect_to admins_customers_path
  end

  def update
  end
end
