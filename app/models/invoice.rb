class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status


  def self.invoice_items_invoice(id)
    joins(:invoice_items).where(invoice_items: {id: id})
  end
end
