class OrderController < ApplicationController
  def new
  end

  def create
    result = ::NewOrderWithItems.new.call(create_params)

    if result.success?
      flash[:notice] = "Success"
    else
      flash[:error] = "Error"
    end
    render :index
  end

  def index
  end

  private

  def create_params
    params.permit(:tax, :orderItems).to_h
  end
end
