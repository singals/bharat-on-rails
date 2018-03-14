# frozen_string_literal: true

json.extract! debtor, :id, :name, :village, :phone, :is_active, :created_at, :updated_at
json.url debtor_url(debtor, format: :json)
