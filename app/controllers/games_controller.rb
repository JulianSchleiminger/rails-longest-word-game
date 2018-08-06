require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letterarray = params[:letters]

    if includes?(@word, @letterarray) && english_check?(@word)
      return @answer = "Congrats! #{@word} is a valid english word!"
    elsif english_check?(@word)
      return @answer = "Sorry, #{@word} can't be built of of #{@letterarray}!"
    else
      return @answer = "Sorry, #{@word} does not seem to be a valid English word!"
    end
  end

  def includes?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_check?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json['found']
  end

end

