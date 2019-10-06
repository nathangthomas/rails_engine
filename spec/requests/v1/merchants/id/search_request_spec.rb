require 'rails_helper'

describe 'merchant search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
  end

  it 'can find an item by search params' do
    get "/api/v1/merchants/find?id=#{@merchant_1.id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant['data']['id'].to_i).to eq(@merchant_1.id)
    expect(merchant['data']['attributes']['name']).to eq(@merchant_1.name)
  end

  it 'can find all merchant matches by search params' do
    get "/api/v1/merchants/find_all?id=#{@merchant_1.id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant['data'][0]['id'].to_i).to eq(@merchant_1.id)
    expect(merchant['data'][0]['attributes']['name']).to eq(@merchant_1.name)
  end

  it 'can return a random merchant' do
    get '/api/v1/merchants/random'
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect([@merchant_1.id, @merchant_2.id]).to include(merchant['data']['id'].to_i)
  end
end
