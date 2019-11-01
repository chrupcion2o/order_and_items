# frozen_string_literal: true

class OrderWithItemsService
  def create(data)
    orderItems = data[:orderItems].map do |item|
      net_total = item['net_price'] * item['quantity']

      {
        net_price: item['net_price'],
        quantity: item['quantity'],
        net_total: net_total,
        total: net_total + (net_total * data[:tax]/100)
      }
    end

    order = {
      net_total: orderItems.sum { |item| item[:net_total] },
      tax: data[:tax],
      total: orderItems.sum { |item| item[:total] }
    }

    {order: order, orderItems: orderItems}
  end
end