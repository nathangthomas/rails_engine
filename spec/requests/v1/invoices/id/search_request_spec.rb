require 'rails_helper'

describe 'invoice search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
  end

  it 'can find an invoice by search params' do
    get "/api/v1/invoices/find?id=#{@invoice_1.id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice['data']['id'].to_i).to eq(@invoice_1.id)
    expect(invoice['data']['attributes']['status']).to eq(@invoice_1.status)
  end

  it 'can return all invoice matches by search params' do
    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice['data'][0]['id'].to_i).to eq(@invoice_1.id)
    expect(invoice['data'][0]['attributes']['status']).to eq(@invoice_1.status)
  end

  it 'can return a random invoice' do
    get '/api/v1/invoices/random'
    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect([@invoice_1.id, @invoice_2.id]).to include(invoice['data']['id'].to_i)
  end
end
