class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :name

  def self.merchant_on_invoice(invoice_id)
    joins(:invoices)
      .where(invoices: {id: invoice_id})
  end
end
