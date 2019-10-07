require 'rails_helper'

describe 'invoice_item search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant One')
    @merchant_2 = Merchant.create!(name: 'Merchant Two')

    @customer_1 = Customer.create!(first_name: 'Nathan', last_name: 'Thomas')

    @item_1 = Item.create!(name: 'Item One', description: "Description One", unit_price: 75107, merchant_id: @merchant_1.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped')

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 375535)

    @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')

    @unit_price = (@invoice_item_1.unit_price/100.to_f).to_s
  end

  it 'can find an invoice_item by search params' do
    get "/api/v1/invoice_items/find?id=#{@invoice_item_1.id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item['data']['id'].to_i).to eq(@invoice_item_1.id)
    expect(invoice_item['data']['attributes']['quantity']).to eq(@invoice_item_1.quantity)
    expect(invoice_item['data']['attributes']['unit_price']).to eq(@unit_price)
  end

  it 'can return all invoice_item matches by search params' do
    get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"

    invoice_item = JSON.parse(response.body)


    expect(response).to be_successful
    expect(invoice_item['data'][0]['id'].to_i).to eq(@invoice_item_1.id)
    expect(invoice_item['data'][0]['attributes']['quantity']).to eq(@invoice_item_1.quantity)
    expect(invoice_item['data'][0]['attributes']['unit_price']).to eq(@unit_price)
  end

  it 'can return a random invoice_item' do
    get "/api/v1/invoice_items/random"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item.keys).to eq(['data'])
  end
end
