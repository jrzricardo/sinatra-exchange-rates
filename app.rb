require "sinatra"
require "sinatra/reloader"
require "http"
get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @currency_list = @parsed_data.fetch("currencies").keys
  
  erb(:homepage)
end
