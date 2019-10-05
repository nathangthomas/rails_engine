class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :best_day, :name, :quantity
end
