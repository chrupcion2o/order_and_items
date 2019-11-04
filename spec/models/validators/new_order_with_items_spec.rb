# frozen_string_literal: true

require 'rails_helper'

describe Validators::NewOrderWithItems do
  let(:validation_data) { { tax: tax, orderItems: orderItems } }
  let(:tax) { 23.to_d }
  let(:orderItems) { [{ net_price: net_price, quantity: quantity }] }
  let(:quantity) { 1.to_d }
  let(:net_price) { 0.to_d }

  describe '#call' do
    context 'valid data' do
      it 'returns success result' do
        result = subject.call(validation_data)
        ap result
        expect(result.success?).to eq(true)
        expect(result.errors).to be_blank
        expect(result.values.data).to eq(validation_data)
      end
    end

    context 'invalid tax' do
      let(:tax) { -1.to_d }
      it 'returns failure result' do
        result = subject.call(validation_data)

        expect(result.success?).to eq(false)
        expect(result.errors).not_to be_blank
        expect(result.errors.to_h).to have_key(:tax)
      end
    end

    context 'invalid quantity' do
      let(:quantity) { 0.to_d }
      it 'returns failure result' do
        result = subject.call(validation_data)

        expect(result.success?).to eq(false)
        expect(result.errors).not_to be_blank
        expect(result.errors.to_h).to have_key(:orderItems)
      end
    end
  end
end
