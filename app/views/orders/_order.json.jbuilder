json.extract! order, :id, :orderNr, :date, :customerName, :customerNumber, :address, :totalPrice, :created_at, :updated_at
json.url order_url(order, format: :json)
