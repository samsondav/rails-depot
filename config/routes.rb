require './app/store'

Depot::Application.routes.draw do
  match 'catalog' => StoreApp.new, via: :all

  get "admin" => "admin#index"

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  get "store/index"
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      post :decrement, on: :member
    end
    resources :carts
    root 'store#index', as: 'store', via: :all
  end
end
