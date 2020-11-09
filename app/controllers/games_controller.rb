require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    if in_grid?
      if JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word.upcase}").read)['found']
        @message = "Congratulations! #{@word.upcase} is a valid English word!"
      else
        @message = "Sorry but #{@word} does not seem to be a valid Enlgish word..."
      end
    else
      @message = "Sorry but #{@word.upcase} can't be built from #{@letters.join(', ')}"
    end
  end

  def in_grid?
    @word.chars.each do |letter|
      if @letters.include?(letter.upcase)
        @letters.delete_at(@letters.index(letter.upcase))
      else
        return false
      end
      return true
    end
  end
end
