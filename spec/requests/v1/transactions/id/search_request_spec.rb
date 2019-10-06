require 'rails_helper'

describe 'transaction search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
    @transaction_2 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 1111405418249632, credit_card_expiration_date: '', result: 'success')
  end

  it 'can find a transaction by search params' do
    get "/api/v1/transactions/find?id=#{@transaction_1.id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction['data']['id'].to_i).to eq(@transaction_1.id)
    expect(transaction['data']['attributes']['result']).to eq(@transaction_1.result)
  end

  it 'can find all transaction matches by search params' do
    get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction['data'][0]['id'].to_i).to eq(@transaction_1.id)
    expect(transaction['data'][0]['attributes']['result']).to eq(@transaction_1.result)
  end

  it 'can return a random transaction' do
    get '/api/v1/transactions/random'
    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect([@transaction_1.id, @transaction_2.id]).to include(transaction['data']['id'].to_i)
  end
end
