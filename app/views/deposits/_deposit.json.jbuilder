# frozen_string_literal: true

json.extract! deposit, :id, :nature, :amount, :debtor_id, :created_at, :updated_at
json.url deposit_url(deposit, format: :json)
