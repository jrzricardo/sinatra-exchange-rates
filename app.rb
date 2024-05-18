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

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @currency_list = @parsed_data.fetch("currencies").keys

  erb(:from_to)
end

get("/:from_currency/:to_currency") do
    @original_currency = params.fetch("from_currency")
    @destination_currency = params.fetch("to_currency")

api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

    @raw_response = HTTP.get(api_url)
    @raw_string = @raw_response.to_s
    @parsed_data = JSON.parse(@raw_string)
    @currency_exchange = @parsed_data.fetch("result")

    erb(:exchange)
end
