Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions',
    passwords: 'customers/passwords'
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
    # post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'

  # namespace :departments do
  #   resources :searches, only: :index
  # end



  devise_scope :customer do
    # get 'customer', to: redirect("/customer/sign_up")
    post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'
  end

  scope module: :customer do
    root to: 'homes#top'
    # post "/" => "homes#top"
    
    # resources :customers
    # patch 'customers/:id' => 'customers#update'

    #patch "customer/:id" => "customers#update"
    # get "customer" => "customers#show"

    # patch "customers/:id/edit" => "customers#update"


    # resource :bookmarks, only: [:create, :destroy]
    # resources :posts
    # get '/post/hashtag/:name' => 'posts#hashtag'
    # get '/post/hashtag' => 'posts#hashtag'

    # resources :customers do
    #   member do
    #     get :bookmarks
    #   end
    # end

    resources :tags do
      get 'posts', to: 'posts#search'
    end

    resources :customers do
      post 'tag/:id' => 'tags#create', as: 'tag'
      delete 'tag/:id' => 'tags#destroy', as: 'unlike'
      get 'posts', to: 'posts#search'
    end

    resources :posts do
      resources :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      # resources :comments, only: %i[create destroy]

      collection do
        get 'search'
        get 'bookmarks'
      end
    end

    resources :comments, only: :destroy
    resources :bookmarks, only: :index


    get '/post/hashtag/:name', to: "posts#hashtag"

    post 'posts/:id/bookmarks'=> 'posts#create', as: 'create_post_bookmarks'
    delete 'posts/:id/bookmarks'=> 'posts#destroy', as: 'destroy_post_bookmarks'

    post "/customer/posts/:id/edit" => "customer/posts#edit"

  end

  # resources :posts do
  #   collection do
  #     get 'search'
  #   end
  # end


# resources :posts, only: [:new, :create, :edit, :show, :update, :destroy] do

#   # get :search, on: :collection
# end


  namespace :admin do
    root to: 'homes#top'
    resources :customers
    resources :comments, only: [:index, :show, :destroy]
  end
end
