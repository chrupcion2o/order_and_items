class OrderController < ApplicationController
  def new
  end

  def create
    result = ::NewOrderWithItems.new.call(create_params)

    if result.success?
      flash[:notice] = 'Success'
    else
      flash[:error] = 'Error'
    end

    redirect_to root_url
  end

  def index
    @orders = Order.all
    @order_items = OrderItem.all
  end

  private

  def create_params
    params.permit(:tax, :orderItems).to_h
  end
end
