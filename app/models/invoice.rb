class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
end 
