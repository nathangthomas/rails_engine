class Api::V1::Items::MerchantController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.merchant_of_item(params[:id]))
  end
end
