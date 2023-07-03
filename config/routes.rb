Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }



  # # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    post 'customers/guest_sign_out', to: 'customers/sessions#new'
    post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'
    get 'customer/guest_sign_up', to: 'customers/sessions#new_guest'
    get 'customer/guest_sign_in',to: 'customers/registrations#new'
  end

  devise_scope :customer do
    get 'customer', to: redirect("/customer/sign_up")
    post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'
  end

  scope module: :customer do
    root to: 'homes#top'
    post "/" => "homes#top"
    post "customer" => "customers#show"
    get "customer/:id" => "customers#show"
    get "customer/edit" => "customers#edit"
    patch "customer" => "customers#update"
    resources :posts, only:[:destroy]
    get "post" => "post#index"
    get "post/new" => "posts#new"
    post "post/new" => "posts#new"
    patch "posts/id" => "posts#update"
    resources :tags, only: %w[index show destroy]
    resources :customers
    get "customer" => "customers#show"
    
    # resource :bookmarks, only: [:create, :destroy]
    # resources :posts
    # get '/post/hashtag/:name' => 'posts#hashtag'
    # get '/post/hashtag' => 'posts#hashtag'

    resources :customers do
      member do
        get :bookmarks
      end
    end
    resources :tags do
      get 'posts', to: 'posts#search'
    end

    resources :posts do
      collection do
        get 'search'
      end
    end

    resources :posts do
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
    resources :comments, only: :destroy
    resources :bookmarks, only: :index

    get '/post/hashtag/:name', to: "posts#hashtag"

    post 'posts/:id/bookmarks'=> 'posts#create', as: 'create_post_bookmarks'
    delete 'posts/:id/bookmarks'=> 'posts#destroy', as: 'destroy_post_bookmarks'


    resources :posts do
      # resources :comments, only: %i[create], shallow: true

      collection do
        get 'bookmarks'
      end
    end
    post "/customer/posts/:id/edit" => "customer/posts#edit"

    resources :customers, only: [:index, :new, :create ,:show ,:update, :edit, :destroy] do
      post 'tag/:id' => 'tags#create', as: 'tag'
      delete 'tag/:id' => 'tags#destroy', as: 'unlike'
      # resources :comments, only: [:create, :destroy]
    end
  end

  # resources :posts do
  #   collection do
  #     get 'search'
  #   end
  # end


resources :posts, only: [:new, :create, :edit, :show, :update, :destroy] do
  # get :search, on: :collection
end


  namespace :admin do
    root to: 'homes#top'
    resources :customers
    resources :comments, only: [:index, :show, :destroy]
  end
end
