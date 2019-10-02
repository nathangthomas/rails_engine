class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :result
end
