class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  # has_many :orders, :through => :menus_orders

  validates_presence_of  :customerName, :customerNumber, :address, :totalPrice
  validates :totalPrice, numericality: { greater_than: 0}

end
