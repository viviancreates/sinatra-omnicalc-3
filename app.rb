require "sinatra"
require "sinatra/reloader"
require "http"

#sinatra loads json for us

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/umbrella") do
  erb(:umbrella_form)
end

post("/process_umbrella") do
  @user_location = params.fetch("user_loc")

  url_encoded_string = @user_location.gsub("", "+")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_encoded_string}&key=" + ENV.fetch("GMAPS_KEY")
  
  @raw_response = HTTP.get(gmaps_url).to_s

  @parsed_response = JSON.parse(@raw_response)

  @loc_hash = @parsed_response.dig("results", 0, "geometry", "location")
  @latitude = @loc_hash.fetch("lat")
  @longitude = @loc_hash.fetch("lng")

  erb(:umbrella_results)
end
