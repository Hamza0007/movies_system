json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :trailer, :featured, :approved
  json.url movie_url(movie, format: :json)
end
