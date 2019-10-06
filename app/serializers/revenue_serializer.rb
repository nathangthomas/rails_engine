class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |i|
    (i.revenue/100.to_f).to_s
  end 
end
