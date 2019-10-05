class Api::V1::Transactions::InvoiceController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Invoice.transaction_invoice(params[:id]))
  end

end
