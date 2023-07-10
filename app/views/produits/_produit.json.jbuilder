json.extract! produit, :id, :name, :price, :created_at, :updated_at
json.url produit_url(produit, format: :json)
