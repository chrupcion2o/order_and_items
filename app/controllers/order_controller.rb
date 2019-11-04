class OrderController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    params.permit(:tax, { orderItems: [:net_price, :quantity] }).to_h.with_indifferent_access
  end
end
