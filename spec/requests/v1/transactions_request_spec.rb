require 'rails_helper'

describe 'Transactions API' do
  before(:each) do

    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')
    @customer_2 = Customer.create!(first_name: 'Camille', last_name: 'Terry')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Item Two', description: "Description Two", unit_price: 67076, merchant_id: @merchant_2.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, merchant_id: @merchant_2.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 335380)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
    @transaction_2 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 9654405418234567, credit_card_expiration_date: '', result: 'failed')
  end

  it 'sends a list of transactions' do
    get '/api/v1/transactions'
    expect(response).to be_successful
    transactions = JSON.parse(response.body)
    expect(transactions.class).to eq Hash
    expect(transactions['data'].count).to eq(2)
    expect(transactions['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(transactions['data'][0]['attributes'].keys).to eq(['id', 'invoice_id', 'result', 'credit_card_number'])
  end

  it 'sends a single transaction' do
    get "/api/v1/transactions/#{@transaction_1.id}"
    expect(response).to be_successful
    transactions = JSON.parse(response.body)
    expect(transactions.class).to eq Hash
    expect(transactions['data'].keys).to eq(['id', 'type', 'attributes'])
    expect(transactions['data']['attributes'].keys).to eq(['id', 'invoice_id', 'result', 'credit_card_number'])
  end
end
