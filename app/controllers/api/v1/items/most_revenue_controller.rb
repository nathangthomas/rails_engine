class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.most_revenue(x)[0])
  end
end
