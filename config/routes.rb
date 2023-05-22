Rails.application.routes.draw do
  get 'homes/top'
  
  # devise_scope :user do
  # end
  
  # devise_scope :customer do
    get "customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
    get 'customers/sign_out' => 'devise/sessions#destroy'
    get 'customers', to: redirect("customers/sign_up")
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  # end
  
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  
    # root to: 'homes#top'
  


  # scope module: :public do
  #   root 'homes#top'
  # end


  #resources :customers

  #devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
