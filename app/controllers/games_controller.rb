require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = ('A'..'Z').map { |i| i }
    @letters = []
    10.times do
      @random_ind = rand(0..(@alphabet.length - 1))
      @random_letter = @alphabet[@random_ind]
      @letters << @random_letter
    end
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters].split(' ')
    @rand = params[:letters]
    @answer.upcase.split('').each do |el|
      if @letters.find_index(el) then @letters[@letters.find_index(el)] = 'used'
      else @letters = [] end
    end
    english_word_check(@answer)
    message(@letters, @found)
  end

  private

  def message(letters, found)
    if letters == []
      @message1 = 'Sorry, but'
      @message2 = "can't be build out of"
    elsif found == false
      @message1 = 'Sorry, but'
      @message2 = 'does not seem to be a valid English word...'
    else
      @message1 = 'Congratulations!'
      @message2 = 'is a valid English word!'
    end
  end

  def english_word_check(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    @word_serialized = URI.open(url).read
    @word = JSON.parse(@word_serialized)
    @found = @word['found']
    @length = @word['length']
  end
end
