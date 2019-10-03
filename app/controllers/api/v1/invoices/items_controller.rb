class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.items_on_invoice(params[:id]))
  end
end
