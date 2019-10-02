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
      merchant_count = 0
      CSV.foreach(merchant_csv, headers: true) do |row|
        merchants << row.to_hash
        merchant_count += 1
      end
      Merchant.import!(merchants)
      p "#{merchant_count} Merchants have been imported!"

      customers = []
      customer_count = 0
      CSV.foreach(customer_csv, headers: true) do |row|
        customers << row.to_hash
        customer_count += 1
      end
      Customer.import!(customers)
      p "#{customer_count} Customers have been imported!"

      items = []
      item_count = 0
      CSV.foreach(item_csv, headers: true) do |row|
        items << row.to_hash
        item_count += 1
      end
      Item.import!(items)
      p "#{item_count} Items have been imported!"

      invoices = []
      invoice_count = 0
      CSV.foreach(invoice_csv, headers: true) do |row|
        invoices << row.to_hash
        invoice_count += 1
      end
      Invoice.import!(invoices)
      p "#{invoice_count} Invoices have been imported!"

      invoice_items = []
      invoice_item_count = 0
      CSV.foreach(invoice_item_csv, headers: true) do |row|
        invoice_items << row.to_hash
        invoice_item_count += 1
      end
      InvoiceItem.import!(invoice_items)
      p "#{invoice_item_count} Invoice_items have been imported!"

      transactions = []
      transaction_count = 0
      CSV.foreach(transaction_csv, headers: true) do |row|
        transactions << row.to_hash
        transaction_count += 1
      end
      Transaction.import!(transactions)
      p "#{transaction_count} Transactions have been imported!"
        line_count = merchant_count + customer_count + item_count + invoice_count + invoice_item_count + transaction_count
      p "#{line_count} sales_engine lines have been successfully imported!"
    end
#   end
# end
