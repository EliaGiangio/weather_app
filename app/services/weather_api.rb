class WeatherApi
  require 'net/http'
  require 'json'
  require 'uri'

  # We use this method to retrieve data for a given city with OpenWeatherApi
  def self.fetch_weather(city)
    api_key = ENV['OPENWEATHER_API_KEY']
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{URI.encode_www_form_component(city)}&appid=#{api_key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    # Data estracted from the API response
    loc_name = data['name']
    weather_main = data['weather'][0]['main']
    weather_desc = data['weather'][0]['description']
    temp = data['main']['temp']

    # Data to return in the controller
    {
      weather_main: weather_main,
      loc_name: loc_name,
      weather_desc: weather_desc,
      temp: temp
    }
  end
end
