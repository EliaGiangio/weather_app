class EntriesController < ApplicationController
    # Initialize a new Entry object for the form at launch
  def index
    @entry = Entry.new
  end
  #when a form is submitted "create" handles the comunnication with the API
  def create
    # location extracted from the form parameters
    location = params[:entry][:location]

    # this block sends "location" data to the API and fetches the response
    weather_data = WeatherApi.fetch_weather(location)
    weather_main = weather_data[:weather_main]
    loc_name = weather_data[:loc_name]
    weather_desc = weather_data[:weather_desc]
    temp = weather_data[:temp]

    # Create a new entry
    @entry = Entry.new(city: loc_name, weather: weather_main, description: weather_desc, temp: temp)

    respond_to do |format|
      if @entry.save
        # If the entry is successfully saved, redirect to the entries path.
        format.html { redirect_to entries_path }
        format.turbo_stream
      else        
        # If the entry fails to save, render the index template again with an error
        format.html { render :index, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end
end
