# frozen_string_literal: true

require 'rails_helper'

describe OrderWithItemsService do
  let(:input) { { tax: tax, orderItems: orderItems } }
  let(:tax) { BigDecimal(23) }
  let(:net_price) { BigDecimal(100) }
  let(:quantity) { BigDecimal(2) }
  let(:item) { { net_price: net_price, quantity: quantity } }
  let(:orderItems) { [item, item] }

  let(:filled_item) do
    {
      net_price: net_price,
      quantity: quantity,
      net_total: 200,
      total: 246
    }
  end

  let(:filled_order) do
    {
      net_total: 400,
      tax: tax,
      total: 492
    }
  end

  describe '#create' do
    it 'returns filled order with items' do
      result = subject.create(input)

      expect(result).to eq(
        order: filled_order,
        order_items: [filled_item, filled_item]
      )
    end
  end
end
