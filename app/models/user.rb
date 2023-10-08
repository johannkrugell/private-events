# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association for events this user has created
  has_many :created_events, class_name: 'Event', foreign_key: 'user_id'

  # Association for events this user is attending
  has_and_belongs_to_many :attended_events, class_name: 'Event', join_table: 'events_users'

  def full_name
    "#{first_name} #{last_name}"
  end
end
