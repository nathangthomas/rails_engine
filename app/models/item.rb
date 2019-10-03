class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def self.items_on_invoice(invoice_id)
    joins(:invoices).where(invoices: {id: invoice_id})
  end

  def self.invoice_items_item(id)
    joins(:invoice_items).where(invoice_items: {id: id})
  end
  
end
