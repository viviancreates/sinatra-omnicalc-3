require "sinatra"
require "sinatra/reloader"

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/umbrella") do
  erb(:umbrella_form)
end

get("/process_umbrella") do
  @user_location = params.fetch("user_loc")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=AIzaSyDKz4Y3bvrTsWpPRNn9ab55OkmcwZxLOHI"
  
  @raw_response = HTTP.get(gmaps_url).to_s

  erb(:umbrella_results)
end
