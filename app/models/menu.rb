class Menu < ApplicationRecord
  validates_presence_of :name, :description, :price
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0}

  has_and_belongs_to_many :orders
end
