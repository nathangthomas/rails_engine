require 'rails_helper'

describe 'Invoices API' do
  before(:each) do

        @merchant_1 = Merchant.create!(name: 'Merchant One')
        @merchant_2 = Merchant.create!(name: 'Merchant Two')

        @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')
        @customer_2 = Customer.create!(first_name: 'Camille', last_name: 'Terry')

        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')
        @invoice_2 = Invoice.create!(customer_id: @customer_2.id, merchant_id: @merchant_2.id, status: 'shipped')

  end

  it 'sends a list of invoices' do
    get '/api/v1/invoices'
    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices.class).to eq Hash
    expect(invoices['data'].count).to eq(2)
    expect(invoices['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(invoices['data'][0]['attributes'].keys).to eq(["customer_id", "merchant_id", "status"])
  end

  it 'sends a single invoice' do
    get "/api/v1/invoices/#{@invoice_1.id}"
    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices.class).to eq Hash
    expect(invoices['data'].keys).to eq(['id', 'type', 'attributes'])
    expect(invoices['data']['attributes'].keys).to eq(["customer_id", "merchant_id", "status"])
  end
end
