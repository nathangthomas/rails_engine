class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def self.items_on_invoice(invoice_id)
    joins(:invoices).where(invoices: {id: invoice_id})
  end

  def self.invoice_items_item(id)
    joins(:invoice_items).
    where(invoice_items: {id: id})
  end

  def self.most_revenue(x)
    joins(:invoice_items)
    .select('items.*,sum(invoice_items.quantity * .invoice_items.unit_price) AS total')
    .group(:id)
    .order('total desc')
    limit(x)
  end

  def self.best_day(item_id)
    joins(:invoices)
      .where(items: {id: item_id})
      .select('items.id, items.name, sum(invoice_items.quantity) AS quantity, invoices.created_at::date AS best_day')
      .group(:best_day)
      .group(:id)
      .order(quantity: :desc)
      .order(best_day: :desc)
      .limit(1)
  end

end
