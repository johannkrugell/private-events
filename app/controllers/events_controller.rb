#  frozen_string_literal: true

# EventsController to handle events
class EventsController < ApplicationController
  # Index to display all events
  def index
    @events = Event.all
  end
end
