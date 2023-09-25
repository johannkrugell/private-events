# frozen_string_literal: true

# database migration to create events table
class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.datetime :date, null: false
      t.string :location, null: false, default: ''
      t.timestamps
    end
  end
end
