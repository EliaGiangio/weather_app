class WeatherApi
  require 'net/http'
  require 'json'
  require 'uri'

  # We use this method to retrieve data for a given location with OpenWeatherApi
  def self.fetch_weather(location)
    api_key = ENV['OPENWEATHER_API_KEY']
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{URI.encode_www_form_component(location)}&appid=#{api_key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    #Very basic and NOT ideal error handling logic, if there is an unexpected api response we feed the variables "No data available"
    if data['weather']

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
  else
    loc_name = 'No data available'
    weather_main = 'No data available'
    weather_desc = 'No data available'
    temp = 'No data available'
    {
      weather_main: weather_main,
      loc_name: loc_name,
      weather_desc: weather_desc,
      temp: temp
    }
  end
  end
end
