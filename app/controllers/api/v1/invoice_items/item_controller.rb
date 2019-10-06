class Api::V1::InvoiceItems::ItemController < ApplicationController

  def show
      render json: ItemSerializer.new(Item.invoice_items_item(params[:id])[0])
  end
end
