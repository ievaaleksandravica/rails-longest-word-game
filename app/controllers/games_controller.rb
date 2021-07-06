class GamesController < ApplicationController
  def new
    @alphabet = ("A".."Z").map { |i| i }
    @letters = []
    10.times do
      @random_ind = rand(0..@alphabet.length-1)
      @random_letter = @alphabet[@random_ind]
      @letters << @random_letter
    end
  end

  def score
    @answer = params[:answer]
  end
end
