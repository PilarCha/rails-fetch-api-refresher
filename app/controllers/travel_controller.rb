class TravelController < ApplicationController
  def index
  end

  def search
    countries = find_country(params[:country])

    unless countries
      flash[:alert] = 'Country not found'
      return render action :index
    end
  end

  private
  def request_api(url)
    response = Excon.get(
      url      
    )

    return nill if response.status != 200

    JSON.parse(response.body)
  end

  def find_country(name)
    request_api("https://restcountries.com/v3.1/name/#{URI.encode(name)}")
end
