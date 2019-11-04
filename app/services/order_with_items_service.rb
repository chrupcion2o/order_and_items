# frozen_string_literal: true

class OrderWithItemsService
  def create(data)
    order_items = data[:orderItems].map do |item|
      fill_order_item(item, data[:tax])
    end

    order = fill_order(order_items, data[:tax])

    { order: order, order_items: order_items }
  end

  private

  def fill_order(order_items, tax)
    {
      net_total: order_items.sum { |item| item[:net_total] },
      tax: tax,
      total: order_items.sum { |item| item[:total] }
    }
  end

  def fill_order_item(item, tax)
    net_total = item[:net_price] * item[:quantity]

    {
      net_price: item[:net_price],
      quantity: item[:quantity],
      net_total: net_total,
      total: net_total + (net_total * tax / 100)
    }
  end
end
