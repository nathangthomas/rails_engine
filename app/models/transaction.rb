class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :transactions, through: :invoices

  validates_presence_of :credit_card_number, :result

  scope :successful, -> { where(result: "success") }


  def self.customer_transactions(cust_id)
    joins(:invoice).where(invoices: {customer_id: cust_id})
  end

  # Transaction.joins(invoice:[:customer]).where(invoices: {customer_id: 1})
end
