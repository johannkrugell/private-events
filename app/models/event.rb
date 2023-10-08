# frozen_string_literal: true

class Event < ApplicationRecord
  # Association for the user who created this event
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  # Association for users attending this event
  has_and_belongs_to_many :attendees, class_name: 'User', join_table: 'events_users'

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :date, presence: true
  validates :location, presence: true, length: { maximum: 50 }

  # scope :past, -> { where('date < ?', Time.zone.now) }
  # scope :upcoming, -> { where('date >= ?', Time.zone.now) }
end
