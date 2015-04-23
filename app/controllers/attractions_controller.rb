class AttractionsController < ApplicationController
  def index
    @spots = client.spots(user_location["latitude"], user_location["longitude"], types: ['restaurant', 'food', 'cafe', 'museum', 'park', 'bakery'], radius: 800)
  end
end
