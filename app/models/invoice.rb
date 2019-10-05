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

  def self.transaction_invoice(transaction_id)
    joins(:transactions).where(transactions: {id: transaction_id})
  end

  def self.revenue(date)
    joins(:transactions, :invoice_items)
    .select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where(created_at: date.to_date.all_day)
    .merge(Transaction.successful)
  end
end
