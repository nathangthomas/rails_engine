class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json:  InvoiceItemSerializer.new(InvoiceItem.order_by_id.where(invoice_item_params))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.order_by_id.find_by(invoice_item_params))
  end

private

# if params[:unit_price]
#   params[:unit_price] = (params[:unit_price].to_f * 100).ceil(2)
# end

  def invoice_item_params

    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f * 100).ceil(2)
    end

    params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :created_at, :updated_at)
  end

end
