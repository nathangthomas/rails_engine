class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |attr|
    (attr.revenue.to_f/100).to_s
  end
end
