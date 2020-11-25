class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :orderNr,       null:false
      t.date :date,             null:false
      t.string :customerName,   null:false
      t.string :customerNumber, null:false
      t.text :address,          null:false
      t.integer :totalPrice,    null:false

      t.timestamps
    end
  end
end
