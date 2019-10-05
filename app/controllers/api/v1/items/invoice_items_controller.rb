class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.items_invoice_items(params[:id]))
  end

end
