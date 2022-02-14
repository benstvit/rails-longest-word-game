require "open-uri"
require "json"


class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @input = params[:answer]
    @letters = params[:letters_array].split

    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    word_serialized = URI.open(url).read
    @result = JSON.parse(word_serialized)

    if @input.chars.all? { |letter| @letters.count(letter) >= @input.count(letter) }
      if @result['found']
        @answer = "Congratulations! #{@input.upcase} is a valid English word!✔️"
      else
        @answer = "Sorry but #{@input.upcase} is not a valid English word!❓"
      end
    else
      @answer = "Sorry but #{@input.upcase} can’t be built out of #{@letters.join(', ')} ⚠"
    end
  end
end
