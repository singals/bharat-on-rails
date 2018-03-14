# frozen_string_literal: true

json.extract! sale, :id, :nature, :debtor_id, :village, :phone, :total_amount, :created_at, :updated_at
json.url sale_url(sale, format: :json)
