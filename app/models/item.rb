class Item < ApplicationRecord
  has_many :invoice_items

  validates_presence_of :name, :description, :unit_price
end
