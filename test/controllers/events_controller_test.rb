# frozen_string_literal: true

require 'test_helper'

# Integration test for EventsController
class EventsControllerTest < ActionDispatch::IntegrationTest
  # User must be logged in to create an event
  test 'should redirect create when not logged in' do
    assert_no_difference 'Event.count' do
      post events_path, params: { event: { title: 'Test Event',
                                           description: 'Test Description',
                                           date: '2020-01-01',
                                           location: 'Test Location' } }
    end
    assert_redirected_to new_user_session_path
  end

  # User does not need to be logged in to view events
  test 'should get index' do
    get events_path
    assert_response :success
  end

  # When a user is logged in they can only see their events on the my_events page
  test 'should get my_events' do
    sign_in users(:john)
    get my_events_path
    assert_response :success
  end
end
