json.extract! article, :id, :name, :package_quantity, :availabe_units, :mrp, :cost, :is_active, :created_at, :updated_at
json.url article_url(article, format: :json)
