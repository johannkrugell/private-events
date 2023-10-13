#  frozen_string_literal: true

# EventsController to handle events
class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :past_events, only: [:my_events]
  before_action :upcoming_events, only: [:my_events]
  before_action :set_event, only: %i[edit update show destroy]
  before_action :check_owner, only: %i[edit update destroy]

  # Index to display all events
  def index
    if params[:view] == 'past'
      @events = Event.past_events
    else # Default to future events if no type is provided or if it's not 'past'
      @events = Event.upcoming_events
    end
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

  def edit
    @event = set_event
  end

  def update
    @event = set_event
    if @event.update(event_params)
      # Redirect to the event display page upon successful update
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      # Render the edit view again with error messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = set_event
    @event.destroy
    flash[:success] = 'Event successfully deleted!'
    redirect_to events_path
  end

  def show
    @event = set_event
    @attendees = @event.attendees
  end

  def my_events
    @my_events = current_user.created_events
  end

  def past_events
    @past_events = current_user.created_events.past_events
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

  def attending
    @attending_events = current_user.attended_events
  end

  def unattend
    event = Event.find(params[:id])
    current_user.attended_events.delete(event)

    # Optionally, redirect the user with a message
    redirect_to attending_events_path, notice: "You're no longer attending this event."
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end

  def set_event
    Event.find(params[:id])
  end

  def check_owner
    @event = set_event
    unless current_user.id == @event.user_id
      redirect_to root_path, alert: "You can't modify this event!"
    end
  end
end
