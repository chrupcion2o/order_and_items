# frozen_string_literal: true

require 'rails_helper'

describe NewOrderWithItems do
  let(:input) { { tax: tax, orderItems: orderItems } }
  let(:tax) { '23.0' }
  let(:net_price) { '100' }
  let(:quantity) { '2.0' }
  let(:item) { { net_price: net_price, quantity: quantity } }
  let(:orderItems) { [item, item] }

  describe '#validate' do
    context 'valid data' do
      it 'returns success result' do
        result = subject.send(:validate, input)

        expect(result.success?).to eq(true)
        expect(result.success).to eq(input)
      end
    end

    context 'invalid data' do
      let(:tax) { 'Not tax' }

      it 'returns failure result' do
        result = subject.send(:validate, input)

        expect(result.success?).to eq(false)
        expect(result.failure).to be_present
      end
    end
  end
end
