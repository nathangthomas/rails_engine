# README

* Ruby version 2.4.1

* Rails version 5.2.3

## Setup

* Run `bundle`

* Run `rake db:{drop,create,migrate}`

* Run `rake import` (This will load CSV data into the database)

* Run `rails s`

* Run `rspec`


## Endpoints

There are six record types: Merchants, Items, Invoices, Invoice Items, Transactions, and Customers.

See `routes.rb` file for a complete list of endpoints.

Below are examples of several endpoints you can try out in your browser. Just run `rails s` in your terminal to get your server running and

### Record Endpoints

* Index: GET "/api/v1/merchants"

* Show: GET "GET /api/v1/merchants/id"

* Single record finder: GET "/api/v1/merchants/find?parameters"

* Multi record finder: GET "/api/v1/merchants/find_all?parameters"

* Random record: GET "api/v1/merchants/random"

### Relationship endpoints

* Merchant Items: GET "/api/v1/merchants/:id/items"

* Merchant Invoices: GET "/api/v1/merchants/:id/invoices"

### Business Intelligence

* Top x Merchants ranked by total revenue: GET "api/v1/merchants/most_revenue/"

* Total revenue for date x across all merchants: GET "api/v1/merchants/revenue/"

* Customer who has conducted the most successful transactions: GET "api/v1/merchants/:id/favorite_customer"
