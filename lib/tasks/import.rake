require 'csv'

# namespace :import do
#   desc 'Import csv files' do
    task import: :environment do
      merchant_csv = 'db/csv/merchants.csv'
      customer_csv = 'db/csv/customers.csv'
      item_csv = 'db/csv/items.csv'
      invoice_csv = 'db/csv/invoices.csv'
      invoice_item_csv = 'db/csv/invoice_items.csv'
      transaction_csv = 'db/csv/transactions.csv'

      merchants = []
      CSV.foreach(merchant_csv, headers: true) do |row|
        merchants << row.to_hash
      end
      Merchant.import!(merchants)
      p 'Merchants have been imported!'

      customers = []
      CSV.foreach(customer_csv, headers: true) do |row|
        customers << row.to_hash
      end
      Customer.import!(customers)
      p 'Customers have been imported!'

      items = []
      CSV.foreach(item_csv, headers: true) do |row|
        items << row.to_hash
      end
      Item.import!(items)
      p 'Items have been imported!'

      invoices = []
      CSV.foreach(invoice_csv, headers: true) do |row|
        invoices << row.to_hash
      end
      Invoice.import!(invoices)
      p 'Invoices have been imported!'

      invoice_items = []
      CSV.foreach(invoice_item_csv, headers: true) do |row|
        invoice_items << row.to_hash
      end
      InvoiceItem.import!(invoice_items)
      p 'Invoice_items have been imported!'

      transactions = []
      CSV.foreach(transaction_csv, headers: true) do |row|
        transactions << row.to_hash
      end
      Transaction.import!(transactions)
      p 'Transactions have been imported!'
      p 'All sales_engine data has been successfully imported!'
    end
#   end
# end
