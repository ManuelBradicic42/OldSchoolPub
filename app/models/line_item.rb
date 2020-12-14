class LineItem < ApplicationRecord
  #creating many-to-many relation
  belongs_to :order
  belongs_to :menu
end
