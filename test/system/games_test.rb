require 'application_system_test_case'

# GamesTest
class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_path
    # assert test: 'New game'
    assert_selector '.card', count: 10
  end
end
