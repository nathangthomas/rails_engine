class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.customer_transactions(params[:id]))
  end
end
