# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'home#home'
  resources :deposits
  resources :profit_and_loss_accounts
  resources :sales do
    resources :sale_items
  end

  resources :purchases do
    resources :purchase_items
  end

  resources :debtors do
    resources :deposits
  end
  resources :articles
end
