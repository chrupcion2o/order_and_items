class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.decimal :net_price
      t.integer :quantity
      t.decimal :net_total
      t.decimal :total
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
