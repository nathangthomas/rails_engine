# README

## About
This project uses Rails and Active Record to build a JSON API which exposes the SalesEngine data schema.

## Setup
* Ruby version 2.4.1
* Rails version 5.2.3

* Run `bundle`

* Run `rake db:{drop,create,migrate}`

* Run `rake import` (This will load CSV data into the database)

* Run `rails s`

* Run `rspec`


## Endpoints

There are six record types: Merchants, Items, Invoices, Invoice Items, Transactions, and Customers.

See `routes.rb` file for a complete list of endpoints.

Below are examples of several endpoints you can try out in your browser.

### Record Endpoints

* Index: GET "/api/v1/merchants"

* Show: GET "/api/v1/merchants/id"

* Single record finder: GET "/api/v1/merchants/find?parameters"

* Multi record finder: GET "/api/v1/merchants/find_all?parameters"

* Random record: GET "api/v1/merchants/random"

### Relationship endpoints

* Merchant Items: GET "/api/v1/merchants/:id/items"

* Merchant Invoices: GET "/api/v1/merchants/:id/invoices"

### Business Intelligence

* Top x Merchants ranked by total revenue: GET "api/v1/merchants/most_revenue"

* Total revenue for date x across all merchants: GET "api/v1/merchants/revenue"

* Customer who has conducted the most successful transactions: GET "api/v1/merchants/:id/favorite_customer"

## Schema

<img width="1192" alt="Screen Shot 2019-10-03 at 11 25 20 AM" src="https://user-images.githubusercontent.com/47466067/66281475-c1674180-e878-11e9-9c2c-33ea877396e1.png">
