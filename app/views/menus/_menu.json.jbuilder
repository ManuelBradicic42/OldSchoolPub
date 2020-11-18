json.extract! menu, :id, :name, :description, :availability, :price, :created_at, :updated_at
json.url menu_url(menu, format: :json)
