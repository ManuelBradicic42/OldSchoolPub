class Menu < ApplicationRecord
  has_many :line_items,dependent: :destroy
  # has_many :orders, :through => :menus_orders

  validates_presence_of :name, :description, :price, :image
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0}

  mount_uploader :image, ImageUploader
end
