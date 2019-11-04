# frozen_string_literal: true

class NewOrderWithItems
  include Dry::Transaction

  step :validate
  step :fill_data
  step :save

  private

  def validate(input)
    input[:tax] = BigDecimal(input[:tax])
    input[:orderItems] = input[:orderItems].map { |item| item.transform_values { |v| BigDecimal(v) } }
    validation_result = ::Validators::NewOrderWithItems.new.call(input)

    if validation_result.success?
      Success(validation_result.values.data)
    else
      Failure(validation_result.errors.to_h)
    end
  rescue StandardError
    Failure('Failed to parse request')
  end

  def fill_data(data)
    result = ::OrderWithItemsService.new.create(data)
    Success(result)
  end

  def save(order_and_items)
    order = Order.new(order_and_items[:order])

    ActiveRecord::Base.transaction do
      order.save!
      order_and_items[:order_items].each { |item| order.order_items.build(item).save! }
    end

    Success('Saved successfully')
  rescue StandardError
    Failure('Failed to save')
  end
end
