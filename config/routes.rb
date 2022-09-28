Rails.application.routes.draw do


  scope module: :public do
    root to: 'homes#top'
    get "/about" => "homes#about"
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        get :thanks
        post :confirm
      end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :customer, controllers: {
    sessions: 'public/devise/sessions',
    passwords: 'public/devise/passwords',
    registrations: 'public/devise/registrations'
  }


  namespace :admin do
    get "/" => "homes#top"
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  devise_for :admin, controllers: {
    sessions: 'admin/devise/sessions',
  }



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
