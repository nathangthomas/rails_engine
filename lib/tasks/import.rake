require 'csv'

namespace :import do
  desc 'Import csv files' do
    task :import => [:environment] do
      customer_file = 'db/csv/customers.csv'
      invoice_item_file = 'db/csv/invoice_items.csv'
      invoice_file = 'db/csv/invoices.csv'
      item_file = 'db/csv/items.csv'
      merchant_file = 'db/csv/merchants.csv'
      transaction_file = 'db/csv/transactions.csv'

      merchants = []
      CSV.foreach(merchant_file, headers: true) do |row|
        merchants << row.to_hash
      end
      Merchant.import!(merchants)
      p 'Merchants have been imported!'

      customers = []
      CSV.foreach(customer_file, headers: true) do |row|
        customers << row.to_hash
      end
      Customer.import!(customers)
      p 'Customers have been imported!'

      items = []
      CSV.foreach(item_file, headers: true) do |row|
        items << row.to_hash
      end
      Item.import!(items)
      p 'Items have been imported!'

      invoices = []
      CSV.foreach(invoice_file, headers: true) do |row|
        invoices << row.to_hash
      end
      Invoice.import!(invoices)
      p 'Invoices have been imported!'

      invoice_items = []
      CSV.foreach(invoice_item_file, headers: true) do |row|
        invoice_items << row.to_hash
      end
      InvoiceItem.import!(invoice_items)
      p 'Invoice_items have been imported!'

      transactions = []
      CSV.foreach(transaction_file, headers: true) do |row|
        transactions << row.to_hash
      end
      Transaction.import!(transactions)
      p 'Transactions have been imported!'
      p 'All sales_engine data has successfully imported!'
    end
  end
end
