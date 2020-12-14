class Order < ApplicationRecord
  #creating many to many relatioship
  has_many :line_items, dependent: :destroy

  #there must the the following fields:
  validates_presence_of  :customerName, :customerNumber, :address, :totalPrice
  #the price has to be greater than 0
  validates :totalPrice, numericality: { greater_than: 0}

end
