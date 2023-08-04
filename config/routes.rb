Rails.application.routes.draw do

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions',
    passwords: 'customers/passwords'
  }
  # # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }
  
  devise_scope :customer do
    post 'customers/guest_sign_out', to: 'customer/sessions#new'
    post 'customers/guest_sign_in', to: 'customer/sessions#new_guest'
    get 'customers/guest_sign_in', to: 'customer/sessions#new_guest'
    get 'customers/guest_sign_up', to: 'customer/sessions#new_guest'
    get 'customers/guest_sign_in',to: 'customer/registrations#new'
    get 'customers/guest_sign_in', to: 'customer/sessions#new_guest'
    delete 'customer/guest_sign_out', to: 'customer/sessions#destroy'
  end
  
  scope module: :customer do
    root to: 'homes#top'
    
    resources :tags do
    end
    get 'tag_search', to: 'posts#hashtags', as: 'tag_search'
    
    resources :customers do
      post 'tag/:id' => 'tags#create', as: 'tag'
      delete 'tag/:id' => 'tags#destroy', as: 'unlike'
      get 'posts', to: 'posts#search'
    end

    resources :posts do
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      
    collection do
      get 'search'
      get 'bookmarks'
    end
  end
  
resources :customers do
  member do
    get :bookmarks
  end
end

    resources :comments, only: :destroy
    resources :bookmarks, only: :index
    post "customer/posts/:id/edit" => "customer/posts#edit"
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :customers
    resources :comments, only: [:index, :show, :destroy]
  end
end