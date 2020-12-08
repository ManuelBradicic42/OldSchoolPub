class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customerName,   null:false
      t.string :customerNumber, null:false
      t.text :address,          null:false
      t.integer :totalPrice,    null:false

      t.timestamps
    end
  end
end
