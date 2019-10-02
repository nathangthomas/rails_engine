require 'rails_helper'

describe 'Customers API' do
  before(:each) do
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @customer_2 = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
  end

  it 'sends a list of customers' do
    get '/api/v1/customers'
    expect(response).to be_successful
    customers = JSON.parse(response.body)
    expect(customers.class).to eq Hash
    expect(customers['data'].count).to eq(3)
    expect(customers['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(customers['data'][0]['attributes'].keys).to eq(['id', 'first_name', 'last_name'])
  end

  it 'sends a a single customer' do
    get "/api/v1/customers/#{@customer_1.id}"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.class).to eq Hash
    expect(merchants['data'].keys).to eq(['id', 'type', 'attributes'])
    expect(merchants['data']['attributes'].keys).to eq(['id', 'first_name', 'last_name'])
  end
end
