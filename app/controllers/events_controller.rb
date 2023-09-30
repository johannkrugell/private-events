#  frozen_string_literal: true

# EventsController to handle events
class EventsController < ApplicationController
  # Index to display all events
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    event = current_user.created_events.build(event_params)
    if event.save
      flash[:success] = 'Event created!'
      redirect_to event
    else
      render 'index'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end
end
