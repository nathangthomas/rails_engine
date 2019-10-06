class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :item_id, :invoice_id

  attribute :unit_price do |item|
    (item.unit_price/100.to_f).to_s
  end
end
