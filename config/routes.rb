Rails.application.routes.draw do
           root to: 'homes#top'
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
       scope module: :customer do
         post "customer" => "customers#create"
         post "customer" => "customers#show"
         get "customer/edit" => "customers#edit"
         #patch  "customer/edit" => "customers#edit"
         patch "customer" => "customers#update"
        resources :customer
        post "post/new" => "posts#new"
          get "customer" => "customers#show"

         resources :post
  end
      
  devise_scope :customer do
    get '/customer/sign_out' => 'devise/sessions#destroy'
    get '/customes', to: redirect("/customer/sign_up")
    get 'customer/guest_sign_up', to: 'customer/sessions#new_guest'
    post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'
    
    get 'customer/guest_sign_in',to: 'customer/registrations#new'
    get 'customer/guest_sign_up', to: 'customer/sessions#new'
  end
  
 


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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end



