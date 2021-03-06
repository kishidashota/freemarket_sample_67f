
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root "items#index"
  resources :categories, only: :index, defaults: { format: 'json' }
  resources :users, only: [:index, :edit, :show, :update] 
    resources :items do
      collection do
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
    end
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'

    resources :credit_card, only: [:new] do
      collection do
        get 'show', to: 'credit_card#show'
        post 'pay', to: 'credit_card#pay'
        post 'delete', to: 'credit_card#delete'
      end
    end
    resources :purchase, only: [:show] do
      member do
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end
  end

  resources :searches,only:[:index] do
    collection do
      get 'detail', to: 'detail_searches_path'
    end
  end

  
end
