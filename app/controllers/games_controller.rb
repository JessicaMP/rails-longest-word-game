# frozen_string_literal: true

require 'net/http'
require 'json'

# GamesController
class GamesController < ApplicationController
  def new
    # self.class.class_eval do
    def generate_grid(grid_size)
      Array.new(grid_size) { ('A'..'Z').to_a.sample }
    end
    @letters = generate_grid(10)
    session[:letters] = @letters
    # end
  end

  def score
    @letters = session[:letters]

    def validate_word(string, grid, is_validate)
      word_upper = string.upcase
      word = word_upper.chars
      return "<p>Sorry but <span class='fw-bold'>#{word_upper}</span> does not seem to be a valid English word...</p>" unless is_validate

      exclude_grid = word.all? { |letter| grid.count(letter) >= word.count(letter) }
      return "<p>SORRY but <span class='fw-bold'>#{word_upper}</span> can't be built out of #{grid.join(', ')}</p>" unless exclude_grid

      "<p>Congratulations! <span class='fw-bold'>#{word_upper}</span> is valid English word!</p>"
    end

    def verificated(word)
      uri = URI("https://dictionary.lewagon.com/#{word}")
      JSON.parse(Net::HTTP.get(uri))
    end


    @word = params[:word]
    @result = verificated(@word)
    @response = validate_word(@word, @letters, @result['found'])
  end
end
