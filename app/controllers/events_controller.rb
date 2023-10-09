#  frozen_string_literal: true

# EventsController to handle events
class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :past_events, only: [:my_events]

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

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def my_events
    @my_events = current_user.created_events
  end

  def past_events
    @past_events = current_user.created_events
  end

  def upcoming_events
    @upcoming_events = current_user.created_events.upcoming_events
  end

  def attend
    event = Event.find(params[:id])

    # Check if the user is already attending the event to prevent duplicates
    unless event.attendees.include?(current_user)
      event.attendees << current_user
    end

    # Redirect or respond as necessary
    redirect_to event, notice: 'You are now attending this event.'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :user_id)
  end
end
