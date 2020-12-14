class Menu < ApplicationRecord
  #creating many to many relationship
  has_many :line_items, dependent: :destroy

  # there must be the following fields:
  validates_presence_of :name, :description, :price
  # each name has to be unique
  validates :name, uniqueness: true
  # price must be greater than 0
  validates :price, numericality: { greater_than: 0}

  # imageuploader field which indicated the path of the picture
  mount_uploader :image, ImageUploader
end
