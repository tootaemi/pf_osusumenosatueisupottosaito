Rails.application.routes.draw do
  # resources :customer
  # namespace :customer do
  #   resources :posts
  #   # post "/posts" => "/customer/posts#index"
  #   # get 'posts/:id', to: 'posts#show'
  #     # get 'posts/:id' => 'posts#show'
  #   end
  # devise_for :customers, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  # }
  #     devise_scope :customer do
  #     get '/customer/sign_out' => 'customer/sessions#destroy'
  #     get '/customer', to: redirect("/customer/sign_up")
  #     #get 'customer/guest_sign_up', to: 'customers/sessions#new_guest'
  #     post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'
  # #get 'customer/guest_sign_in',to: 'customers/registrations#new'
  #     #get 'customer/guest_sign_up', to: 'customers/sessions#new'
  #     get "customer/sign_up" => "customer/registrations#new"
  #     delete "customer/sign_out"  => "customer/sessions#destroy"
  #   end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customer,skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  # # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  devise_scope :admin do
      delete "admin/sign_out"  => "admin/sessions#destroy"
end



  # devise_for :customers
  devise_scope :customer do
  # post 'customer/guest_sign_in', to: 'customers/sessions#new_guest'
  post 'customers/guest_sign_out', to: 'customers/sessions#new'
  post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'

  get 'customer/sign_out' => 'customer/sessions#destroy'
  get 'customer/guest_sign_up', to: 'customers/sessions#new_guest'
  get 'customer/guest_sign_in',to: 'customers/registrations#new'
  get "customer/sign_up" => "customer/registrations#new"
  delete "customer/sign_out"  => "customer/sessions#destroy"
  end

  scope module: :customer do
    root to: 'homes#top'
    post "/" => "homes#top"
    # post "customer" => "customers#create"
    post "customer" => "customers#show"
    get "customer/edit" => "customers#edit"
    #patch  "customer/edit" => "customers#edit"
    patch "customer" => "customers#update"
    # root to: 'posts#index'
    resources :posts
    #, except: %w[index]

    resources :tags, only: %w[index show destroy]
    resources :customers
    get "customer" => "customers#show"
    get "post/new" => "posts#new"
    post "post/new" => "posts#new"
    patch "posts/id" => "posts#update"
    resources :bookmarks
    post "bookmarks/:post_id/create" => "bookmarks#create"
    post "bookmarks/:post_id/destroy" => "bookmarks#destroy"
    
    # patch "posts/:id" => "posts#update"
    # post "post/:id" => "post#show"
    # resources :post

    resources :tags do
    get 'posts', to: 'posts#search'
  end

  resources :posts do
  resources :bookmarks
end

  # resources :posts, except: [:index] do
  #   resource :bookmarks, only: [:create, :destroy]
  # end

       post 'posts/:id/bookmarks'=> 'posts#create', as: 'create_post_bookmarks'
     delete 'posts/:id/bookmarks'=> 'posts#destroy', as: 'destroy_post_bookmarks'

     resources :posts do
       resource :bookmarks, only: [:create, :destroy]
    end

  # root 'static_pages#top'
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
  resources :comments, only: [:create]
  end
  resources :comments, only: [:create, :destroy]
  resources :posts do
  resources :comments, only: %i[create], shallow: true

    # /posts/bookmarksのURLを作っている。このURLのブックマークの一覧を表示する。
    collection do
      get 'bookmarks'
    end
  end
  # ブックマークのcreateアクションとdestroyアクション
  resources :bookmarks, only: %i[create destroy]




    resources :customers, only: [:index, :new, :create ,:show ,:update, :edit, :destroy] do
      post 'tag/:id' => 'tags#create', as: 'tag'
      delete 'tag/:id' => 'tags#destroy', as: 'unlike'
      resources :comments, only: [:create, :destroy]
      collection do
        get 'search'
      end
    # end
  end
end



 # resources :users do
#   get :search, on: :collection
# end

# resources :posts, only: [:new, :create, :edit, :show, :update, :destroy] do
#   get :search, on: :collection
# end



# devise_for :customers, controllers: {
#     sessions: 'customer/sessions',
#     registrations: 'customer/registrations',
#   }



  # devise_scope :customers do
  #   get "sign_in", :to => "customers/sessions#new"
  #   get "sign_out", :to => "customers/sessions#destroy"
  #   post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  #   post '/customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  #   get '/users/guest_sign_in', to: 'users/guest_sign_in#new'
  #   # post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'

  #   get "/customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
  #   get '/customers/sign_out' => 'devise/sessions#destroy'
  #   # get 'customers', to: redirect("customers/sign_up")
  # end

  # devise_for :customers, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  # }

#   devise_scope :user do
#   get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
# end

# # 以下を追加
#   devise_scope :user do
#     post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
#   end

 namespace :admin do
  root to: 'homes#top'

  resources :customers
  resources :commentss
end


end

