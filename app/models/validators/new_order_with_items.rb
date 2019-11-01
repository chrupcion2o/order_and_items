# frozen_string_literal: true

module Validators
  class NewOrderWithItems < Dry::Validation::Contract
    params do
      required(:tax).filled(:decimal, gteq?: 0)
      required(:orderItems).each do
        schema do
          required(:net_price).filled(:decimal, gteq?: 0)
          required(:quantity).filled(:decimal, gt?: 0)
        end
      end
    end
  end
end
