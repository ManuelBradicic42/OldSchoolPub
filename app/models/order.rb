class Order < ApplicationRecord
  validates_presence_of  :date, :customerName, :customerNumber, :address, :totalPrice
  validates :orderNr, uniqueness: true
  validates :totalPrice, numericality: { greater_than: 0}

  has_and_belongs_to_many :menus
end
