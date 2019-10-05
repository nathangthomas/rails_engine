class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :revenue do |i|
    (i.revenue/100).to_f
  end
end
