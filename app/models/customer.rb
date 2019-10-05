class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.customer_on_invoice(invoice_id)
  joins(:invoices)
    .where(invoices: {id: invoice_id})
  end

  def self.favorite_customer(merchant_id)
    joins(invoices:[:merchant, :transactions]).
    select('customers.*, COUNT(*) AS total').
    group(:id).
    where(invoices:{merchant_id: merchant_id}).
    merge(Transaction.successful).
    order(total: :desc).
    limit(1)
  end

end
