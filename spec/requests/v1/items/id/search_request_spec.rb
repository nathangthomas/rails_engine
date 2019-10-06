require 'rails_helper'

describe 'item search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)

    @item_2 = Item.create!(name: 'Item Two', description: "Description Two", unit_price: 75107, merchant_id: @merchant_2.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
  end

  it 'can find an item by search params' do
    get "/api/v1/items/find?id=#{@item_1.id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item['data']['id'].to_i).to eq(@item_1.id)
    expect(item['data']['attributes']['name']).to eq(@item_1.name)
  end

  it 'can find all item matches by search params' do
    get "/api/v1/items/find_all?id=#{@item_1.id}"

    item = JSON.parse(response.body)
    binding.pry
    expect(response).to be_successful
    expect(item['data'][0]['id'].to_i).to eq(@item_1.id)
    expect(item['data'][0]['attributes']['name']).to eq(@item_1.name)
  end

  it 'can return a random item' do
    get '/api/v1/items/random'
    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect([@item_1.id, @item_2.id]).to include(item['data']['id'].to_i)
  end
end
