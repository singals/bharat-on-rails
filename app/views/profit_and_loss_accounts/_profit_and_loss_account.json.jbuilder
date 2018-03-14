# frozen_string_literal: true

json.extract! profit_and_loss_account, :id, :description, :amount, :current_balance, :financial_year, :created_at, :updated_at
json.url profit_and_loss_account_url(profit_and_loss_account, format: :json)
