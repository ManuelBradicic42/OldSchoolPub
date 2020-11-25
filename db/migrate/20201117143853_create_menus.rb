class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name,         null: false
      t.text :description,    null: false
      t.boolean :availability
      t.float :price,         null: false

      t.timestamps
    end
  end
end
