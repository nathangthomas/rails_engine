class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Invoice.invoice_items_invoice(params[:id])[0])
  end

end
