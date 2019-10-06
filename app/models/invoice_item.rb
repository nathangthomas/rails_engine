class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity, :unit_price

  scope(:order_by_id, -> { order(id: :asc) })

  def self.items_invoice_items(id)
    joins(:item).where(items: {id: id})
  end
end
