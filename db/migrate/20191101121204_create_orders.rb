class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :net_total
      t.decimal :tax
      t.decimal :total

      t.timestamps
    end
  end
end
