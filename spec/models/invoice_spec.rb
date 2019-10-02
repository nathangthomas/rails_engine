require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Relationships' do
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
    it {should belong_to :customer}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'Validations' do
    it {should validate_presence_of :status}
  end
end 
