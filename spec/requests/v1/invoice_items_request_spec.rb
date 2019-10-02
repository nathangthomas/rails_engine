require 'rails_helper'

describe 'InvoiceItmes API' do
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
  end

  it 'sends a list of invoice_items' do
    get '/api/v1/invoice_items'
    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.class).to eq Hash
    expect(invoice_items['data'].count).to eq(2)
    expect(invoice_items['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(invoice_items['data'][0]['attributes'].keys).to eq(['id', 'quantity', 'unit_price'])
  end

  it 'sends a single invoice_item' do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}"
    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.class).to eq Hash
    expect(invoice_items['data'].keys).to eq(['id', 'type', 'attributes'])
    expect(invoice_items['data']['attributes'].keys).to eq(['id', 'quantity', 'unit_price'])
  end
end
