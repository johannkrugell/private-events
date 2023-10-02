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

  def my_events
    @my_events = current_user.created_events
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :user_id)
  end

  def correct_user
    @event = current_user.created_events.find_by(id: params[:id])
    redirect_to root_url if @event.nil?
  end
end
