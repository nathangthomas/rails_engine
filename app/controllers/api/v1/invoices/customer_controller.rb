class Api::V1::Invoices::CustomerController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.customer_on_invoice(params[:id]))
  end
end
