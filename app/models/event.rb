# frozen_string_literal: true

class Event < ApplicationRecord
  # event model with event name, description, date, and location
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  # has_many :event_attendees, foreign_key: :attended_event_id
  # has_many :attendees, through: :event_attendees, source: :attendee

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :date, presence: true
  validates :location, presence: true, length: { maximum: 50 }

  # scope :past, -> { where('date < ?', Time.zone.now) }
  # scope :upcoming, -> { where('date >= ?', Time.zone.now) }
end
