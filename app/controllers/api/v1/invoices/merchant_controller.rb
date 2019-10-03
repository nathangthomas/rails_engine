class Api::V1::Invoices::MerchantController < ApplicationController

  def show
      render json: MerchantSerializer.new(Merchant.merchant_on_invoice(params[:id]))
  end

end
