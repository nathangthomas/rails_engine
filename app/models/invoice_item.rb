class Invoice_Item < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
end
