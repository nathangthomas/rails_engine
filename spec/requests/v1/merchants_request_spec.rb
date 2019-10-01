require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)

    expect(merchants.class).to eq 'Array'
    expect(merchants['data'].count).to eq(3)
    expect(merchants['data'][0].keys).to eq(['id', 'type', 'attributes'])
    expect(merchants['data'][0]['attributes'].keys).to eq('name')
  end
end
