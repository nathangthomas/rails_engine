Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end

      namespace :invoices do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :invoice_items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get  '/:id/invoice', to: 'invoice#show'
        get  '/:id/item', to: 'item#show'
      end

      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/:id/best_day', to: 'best_day#show'
      end

      namespace :transactions do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
      end

      namespace :customers do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
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
