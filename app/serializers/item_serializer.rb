class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |item|
    (item.unit_price/100.to_f).to_s
  end
end
