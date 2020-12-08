json.extract! line_item, :id, :order_id, :menu_id, :created_at, :updated_at
json.url line_item_url(line_item, format: :json)
