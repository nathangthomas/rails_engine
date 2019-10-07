class Api::V1::Merchants::RevenueController < ApplicationController

  def show

    render json: RevenueSerializer.new(Invoice.revenue(params[:date])[0])
  end

end
