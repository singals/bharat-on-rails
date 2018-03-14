# frozen_string_literal: true

json.extract! purchase, :id, :seller_name, :city, :phone, :invoice_number, :total_cost, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
