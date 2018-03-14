# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :profit_and_loss_accounts
  resources :sales do
    resources :sale_items
  end

  resources :purchases do
    resources :purchase_items
  end

  resources :debtors
  resources :articles
end
