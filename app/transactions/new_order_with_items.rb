# frozen_string_literal: true

class NewOrderWithItems
  include Dry::Transaction

  step :validate
  step :fill_data
  step :save

  private

  def validate(input)
    input['tax'] = input['tax'].to_d
    input['orderItems'] = JSON.parse(input['orderItems']).map { |e| e.transform_values(&:to_d) }

    validation_result = ::Validators::NewOrderWithItems.new.call(input)

    if validation_result.success?
      Success(validation_result.values.data)
    else
      Failure(validation_result.errors.to_h)
    end
  end

  def fill_data(data)
    result = ::OrderWithItemsService.new.create(data)
    Success(result)
  end

  def save(order_and_items)
    Success()
  end
end
