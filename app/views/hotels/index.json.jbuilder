json.array!(@hotels) do |hotel|
  json.extract! hotel, :id, :name, :region_id, :city_id
  json.url hotel_url(hotel, format: :json)
end
