require 'rails_helper'

describe 'Invoice InvocieItems' do
  before(:each) do

    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')
    @customer_2 = Customer.create!(first_name: 'Camille', last_name: 'Terry')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Item Two', description: "Description Two", unit_price: 67076, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Item Three', description: "Description Three", unit_price: 12345, merchant_id: @merchant_2.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, merchant_id: @merchant_1.id, status: 'shipped')
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_2.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 335380)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')
    @transaction_2 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 9654405418234567, credit_card_expiration_date: '', result: 'failed')
    @transaction_3 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 9654405418234567, credit_card_expiration_date: '', result: 'failed')

    @unit_price = (@invoice_item_2.unit_price/100.to_f).to_s
  end

  it 'sends a collection of associated invoice_items' do
    get "/api/v1/invoices/#{@invoice_1.id}/invoice_items"
    expect(response).to be_successful
    invoice_invoice_items = JSON.parse(response.body)
    expect(invoice_invoice_items.class).to eq Hash
    expect(invoice_invoice_items['data'].count).to eq(2)
    expect(invoice_invoice_items['data'][0]['attributes']['quantity']).to eq(@invoice_item_1.quantity)
    expect(invoice_invoice_items['data'][1]['attributes']['unit_price']).to eq(@unit_price)
  end
end
