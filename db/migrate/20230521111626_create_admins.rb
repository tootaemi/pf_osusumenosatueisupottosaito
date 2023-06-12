class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :email,                           null: false, default: ""
      t.string :encrypted_password,              null: false, default: ""
      t.timestamps null: false

    end
  end
end

       <% if customer_signed_in? %>
           <!--カスタマーがログインしている時　-->
           <li class="customer-name">
            ようこそ、<%= current_customer.first_name %>さん！
           </li>
           <li><%= link_to "マイページ", customer_path(current_customer) %></li>
           <li><%= link_to "商品一覧", products_path  %></li>
           <li><%= link_to "カート", cart_products_path %></li>
           <li><%= link_to "ログアウト", destroy_customer_session_path, method: :delete %></li>
          <% elsif admin_signed_in? %>
           <!--管理者がログインしている時 -->
            <li><%= link_to "商品一覧", admin_products_path %></li>
            <li><%= link_to "会員一覧", admin_customers_path %></li>
            <li><%= link_to "注文履歴一覧", admin_orders_path %></li>
            <li><%= link_to "ジャンル一覧", admin_genres_path %></li>
            <li><%= link_to "ログアウト", destroy_admin_session_path, method: :delete %></li>
            <%= render "layouts/search" %>
          <% else %>
           <!--ログインしていない時　-->
            <li><%= link_to "about", about_path %></li>
            <li><%= link_to "商品一覧", products_path %> </li>
            <li><%= link_to "新規登録", new_customer_registration_path %></li>
            <li><%= link_to "ログイン", new_customer_session_path %></li>
          <% end %>