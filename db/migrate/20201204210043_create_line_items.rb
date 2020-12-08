class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.belongs_to :order, foreign_key: true
      t.belongs_to :menu, foreign_key: true

      t.timestamps
    end
  end
end
