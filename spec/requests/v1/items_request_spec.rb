require 'rails_helper'

describe 'Items API' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Item Two', description: "Description Two", unit_price: 67076, merchant_id: @merchant_2.id)
  end

  it 'sends a list of items' do
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.class).to eq Hash
    expect(items['data'].count).to eq(2)
    expect(items['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(items['data'][0]['attributes'].keys).to eq(['id', 'name', 'description', 'merchant_id', 'unit_price'])
  end

  it 'sends a single item' do
    get "/api/v1/items/#{@item_1.id}"
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.class).to eq Hash
    expect(items['data'].keys).to eq(['id', 'type', 'attributes'])
    expect(items['data']['attributes'].keys).to eq(['id', 'name', 'description', 'merchant_id', 'unit_price'])
  end
end
