require 'rails_helper'

describe 'customer search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')
    @customer_2 = Customer.create!(first_name: 'Camille', last_name: 'Terry')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)

    @item_2 = Item.create!(name: 'Item Two', description: 'Description Two', unit_price: 11111, merchant_id: @merchant_1.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)

    @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 11111)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
  end

  it 'can find a customer by search params' do
    get "/api/v1/customers/find?id=#{@customer_1.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer['data']['id'].to_i).to eq(@customer_1.id)
    expect(customer['data']['attributes']['first_name']).to eq(@customer_1.first_name)
    expect(customer['data']['attributes']['last_name']).to eq(@customer_1.last_name)
  end

  it 'can return all customer matches by search params' do
    get "/api/v1/customers/find_all?id=#{@customer_1.id}"
    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer['data'][0]['id'].to_i).to eq(@customer_1.id)
    expect(customer['data'][0]['attributes']['first_name']).to eq(@customer_1.first_name)
    expect(customer['data'][0]['attributes']['last_name']).to eq(@customer_1.last_name)
  end

  it 'can return a random customer' do
    get '/api/v1/customers/random'
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect([@customer_1.id.to_i, @customer_2.id.to_i]).to include(customer['data']['id'].to_i)
  end
end
