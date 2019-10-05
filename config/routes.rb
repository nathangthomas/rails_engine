Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/most_revenue/', to: 'most_revenue#index'
        get '/revenue/', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'


    # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
      end

      namespace :invoices do
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :invoice_items do
        get  '/:id/invoice', to: 'invoice#show'
        get  '/:id/item', to: 'item#show'
      end

      namespace :items do
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :transactions do
        get '/:id/invoice', to: 'invoice#show'
      end

      namespace :customers do
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
