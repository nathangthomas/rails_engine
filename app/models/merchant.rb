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

  def self.merchant_of_item(item_id)
    joins(:items).where(items: {id: item_id})
  end

  def self.most_revenue(quantity)
    joins(invoices:[:transactions, :invoice_items]).select('merchants.*,sum(invoice_items.quantity * invoice_items.unit_price) AS total').
    group(:id).
    merge(Transaction.successful).
    order(total: :DESC).
    limit(quantity)
  end

  def self.favorite_merchant(customer_id)
      joins(invoices: [:transactions, :customer])
      .select('merchants.*, COUNT(*) AS total')
      .group(:id)
      .where(invoices: {customer_id: customer_id})
      .merge(Transaction.successful)
      .order(total: :desc)
      .limit(1)
  end
end
