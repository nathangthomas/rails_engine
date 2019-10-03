class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.customer_on_invoice(invoice_id)
  joins(:invoices)
    .where(invoices: {id: invoice_id})
  end
end
