require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Klein, Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')
  end

  it 'sends a list of merchants' do
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.class).to eq Hash
    expect(merchants['data'].count).to eq(3)
    expect(merchants['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(merchants['data'][0]['attributes'].keys).to eq(['name'])
  end

  it 'sends a a single merchant' do
    get "/api/v1/merchants/#{@merchant_1.id}"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.class).to eq Hash
    expect(merchants['data'].keys).to eq(['id', 'type', 'attributes'])
    expect(merchants['data']['attributes'].keys).to eq(['name'])
  end
end
